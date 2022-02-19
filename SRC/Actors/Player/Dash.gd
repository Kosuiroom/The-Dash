extends PlayerState

var input_direction: Vector2

func enter(msg := {}) -> void:
	if msg.has("do_dash"):
<<<<<<< HEAD
		player.dashTimer.start()

func physics_update(_delta) -> void:
	
	print(player.DashAmount)

	if is_dashing() and player.DashAmount == 1:
		player.DashAmount = 0
=======
		player.dashing = true
		player.DashAmount = 0
		player.dashTimer.start()

func physics_update(_delta) -> void:

	if player.dashing and player.DashAmount == 0:
>>>>>>> e31326164c8003015019cdc46f9e7f450d297bfe
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

<<<<<<< HEAD

func is_dashing():
	return !player.dashTimer.is_stopped()

func _on_dash_timer_timeout():
	print("stoped dashing")
=======
func _on_dash_timer_timeout():
>>>>>>> e31326164c8003015019cdc46f9e7f450d297bfe
	
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	elif player.is_on_floor() && Vector2.ZERO:
<<<<<<< HEAD
=======
		player.dashing = false
>>>>>>> e31326164c8003015019cdc46f9e7f450d297bfe
		player.DashAmount = 1
		state_machine.transition_to("Idle")
		
	if player.is_on_floor() && Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		player.JumpSound.play()
	elif Vector2.ZERO:
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("mvLeft") or Input.is_action_pressed("mvRight"):
		state_machine.transition_to("Run")	
	
