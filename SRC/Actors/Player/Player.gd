extends KinematicBody2D

var Speed : float = 0.0
export var maxSpeed : float = 600.0
export var acceleration : float = 200.0
export var jump : float = 3000.0
export var gravity : float = 2500.0
const UP : Vector2 = Vector2.UP
var velocity = Vector2()

func _physics_process(delta):
	apply_gravity(delta)
	get_input(delta)
	print(velocity.x)
	move_and_slide(velocity, UP)
	
func apply_gravity(delta : float) -> void:
	velocity.y = gravity * delta;

func get_input(delta):
	if Input.is_action_pressed("ui_left"):
		speed_calc(delta)
		velocity.x = -Speed
		
	elif Input.is_action_pressed("ui_right"):
		speed_calc(delta)
		velocity.x = Speed
	else:
		Speed = 0
		velocity.x = 0
	if is_on_floor():
		if Input.is_action_just_pressed("player_jump"):
			velocity.y -= jump
			
func speed_calc(delta): 
	Speed += acceleration * delta
	if Speed > maxSpeed:
		Speed = maxSpeed
