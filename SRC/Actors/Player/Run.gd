extends PlayerState

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	var input_direction_x: float = (
		Input.get_action_strength("mvRight")
		- Input.get_action_strength("mvLeft")
	)
	
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		player.JumpSound.play()
	elif Input.is_action_just_pressed("Dash"):
		state_machine.transition_to("Dash", {do_dash = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
