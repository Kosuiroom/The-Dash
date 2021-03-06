# Air.gd
extends PlayerState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.PlayerJump

func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x: float = (
		Input.get_action_strength("mvRight")
		- Input.get_action_strength("mvLeft")
	)
	player.velocity.x = player.speed * input_direction_x
	# Vertical movement.
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	# Landing.
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			player.DashAmount = 1
			player.dashing = false
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	if Input.is_action_just_pressed("Dash") and player.DashAmount != 0:
		state_machine.transition_to("Dash", {do_dash = true})
