extends PlayerState

var input_direction: Vector2

func enter(msg := {}) -> void:
	if msg.has("do_dash"):
		player.dashing = true
		player.canDash = false
		player.dashTimer.start()
		print("dashing: ", player.dashing)

func physics_update(_delta) -> void:
	
	if player.dashing:
		input_direction = Vector2(
			int(Input.get_action_strength('mvRight')) - int(Input.get_action_strength("mvLeft")),
			int(Input.get_action_strength('mvDown')) - int(Input.get_action_strength('mvUp'))
			)

	print("input: ", input_direction)

	player.velocity = player.dashSpeed * input_direction
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)


func _on_dash_timer_timeout():
	print("stoped dashing")
	player.dashing = false
	player.canDash = true
	
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	elif player.is_on_floor() && Vector2.ZERO:
		state_machine.transition_to("Idle")
		
	if player.is_on_floor() && Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		player.JumpSound.play()
	elif Vector2.ZERO:
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("mvLeft") or Input.is_action_pressed("mvRight"):
		state_machine.transition_to("Run")	
	
