#extends "res://SRC/Actors/Player/Actor.gd"
#onready var animated_player = $AnimatedPlayer
#
#var velocity = Vector2.ZERO
#export var max_run = 100
#export var run_accel = 800
#export var gravity = 40
#export var max_fall = 160
#export var jump_force = -160
#
#func _process(delta):
#	var direction = sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
#	#var on_ground = global_position.y >= 160
#
#
#	if direction > 0:
#		animated_player.flip_h = false
#	elif direction < 0:
#		animated_player.flip_h = true
#
#	if direction !=0:
#		animated_player.play ("Running")
#	else:
#		animated_player.play("Idle")
#
#
#	velocity.x = move_toward(velocity.x, max_run * direction, run_accel * delta)
#	velocity.y = move_toward(velocity.y, max_fall, gravity * delta)
#
#	move_x(velocity.x * delta)
#	move_y(velocity.y * delta)
	

extends KinematicBody2D

var velocity = Vector2(0,0)
export var maxSpeed  = 600
export var acceleration  = 200
export var jump = 900
export var gravity = 35
export var jump_hold_time = 0.2
export var local_hold_time = 0
var moveSpeed = 180

export var dashSpeed = 1000
var dashing = false
var lerprate = 0.1
var direction = 0
var notMoving = true

onready var animation = $AnimatedPlayer

func _physics_process(delta):
	get_input(delta)
	##print(velocity.x)
	velocity.y = velocity.y + gravity;
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "MudCrawler":
			print("I collided with ", collision.collider.name)
	
func get_input(delta):
	if Input.is_action_pressed("mvLeft"):
		animation.play("Running")
		$AnimatedPlayer.flip_h = true
		direction = -1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,-moveSpeed,lerprate)
	elif Input.is_action_pressed("mvRight"):
		animation.play("Running")
		$AnimatedPlayer.flip_h = false
		direction = 1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,moveSpeed,lerprate)
	else:
		notMoving = true
		animation.play("Idle")
		moveSpeed = 0
		velocity.x = lerp(velocity.x,moveSpeed,lerprate)
		
#	if is_on_floor():
#		if Input.is_action_pressed("player_jump"):
#			Jumping = true
#			animation.play("Jumping")
#			velocity.y -= jump
#			local_hold_time = jump_hold_time
#			#$Player_Jump.play()
#			if local_hold_time > 0:
#				if Jumping:
#					velocity.y = jump
#				else:
#					local_hold_time = 0
#
#			local_hold_time -= delta
				
	var jumping = Input.is_action_pressed("player_jump")
	print(jumping)
	if jumping && is_on_floor():
		velocity.y = jump
		local_hold_time = jump_hold_time
	elif local_hold_time > 0:
		if jumping:
			velocity.y = jump
		else:
			local_hold_time = 0

	local_hold_time -= delta
	print(local_hold_time)
	
	if Input.is_action_just_pressed("Dash") && dashing == false && notMoving == false:
		dash()

func speed_calc(delta): 
	moveSpeed += acceleration * delta
	if moveSpeed > maxSpeed:
		moveSpeed = maxSpeed
		
func dash() -> void:
	dashing = true
	velocity.x = dashSpeed * direction
	yield(get_tree().create_timer(0.3), "timeout")
	dashing = false
	pass
