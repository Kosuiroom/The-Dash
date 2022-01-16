extends PlayerState

var dash_length = 0.2

func enter(msg := {}) -> void:
	if msg.has("do_dash"):
		player.dashing = true
		player.dashTimer.start(dash_length)
		print("dashing: ", player.dashing)

func physics_update(delta: float) -> void:
	
	var input_direction_x: float = (
		Input.get_action_strength("mvRight")
		- Input.get_action_strength("mvLeft")
	)

	player.velocity.x = player.dashSpeed * input_direction_x
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
		
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
