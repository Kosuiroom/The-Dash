extends PlayerState

var input_direction: Vector2

func enter(msg := {}) -> void:
	if msg.has("do_dash"):
		player.dashing = true
		player.DashAmount = 0
		player.dashTimer.start()

func physics_update(_delta) -> void:

	if player.dashing and player.DashAmount == 0:
		input_direction = Vector2(
			Input.get_action_strength('mvRight') - Input.get_action_strength("mvLeft"),
			Input.get_action_strength('mvDown') - Input.get_action_strength('mvUp')
			)

		player.velocity = player.dashSpeed * input_direction
		player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.is_on_floor():
		player.dashing = false
		player.DashAmount = 1
		state_machine.transition_to("Idle")

func _on_dash_timer_timeout():
	
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	elif player.is_on_floor() && Vector2.ZERO:
		player.dashing = false
		player.DashAmount = 1
		state_machine.transition_to("Idle")
		
	if player.is_on_floor() && Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		player.JumpSound.play()
	elif Vector2.ZERO:
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("mvLeft") or Input.is_action_pressed("mvRight"):
		state_machine.transition_to("Run")	
	
