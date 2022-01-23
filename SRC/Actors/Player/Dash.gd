extends PlayerState

var input_direction_x: float

func enter(msg := {}) -> void:
	if msg.has("do_dash"):
		player.dashing = true
		player.canDash = false
		player.dashTimer.start()
		print("dashing: ", player.dashing)

func physics_update(delta: float) -> void:
	
	player.velocity.y = 0
	
	if player.dashing:
		input_direction_x = (
			Input.get_action_strength("mvRight")
			- Input.get_action_strength("mvLeft")
		)

		player.velocity.x = player.dashSpeed * input_direction_x
		player.velocity = player.move_and_slide(player.velocity, Vector2.UP)


func _on_dash_timer_timeout():
	print("stoped dashing")
	player.dashing = false
	player.canDash = true
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {})
		player.JumpSound.play()
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("mvLeft") or Input.is_action_pressed("mvRight"):
		state_machine.transition_to("Run")	
	
