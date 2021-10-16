extends KinematicBody2D

export var maxSpeed : float = 600.0
export var acceleration : float = 200.0
export var jump : float = 3000.0
export var gravity : float = 2500.0
export var dashSpeed = 1000

const UP : Vector2 = Vector2.UP
var Speed : float = 0.0
var velocity = Vector2()
var dashing = false
var lerprate = 0.1
var direction = 0
var notMoving = true

func _physics_process(delta):
	apply_gravity(delta)
	get_input(delta)
	##print(velocity.x)
	move_and_slide(velocity, UP)
	
func apply_gravity(delta : float) -> void:
	velocity.y = gravity * delta;

func get_input(delta):
	if Input.is_action_pressed("mvLeft"):
		direction = -1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,-Speed,lerprate)
	elif Input.is_action_pressed("mvRight"):
		direction = 1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,Speed,lerprate)
	else:
		notMoving = true
		Speed = 0
		velocity.x = lerp(velocity.x,Speed,lerprate)
		
	if is_on_floor():
		if Input.is_action_just_pressed("player_jump"):
			velocity.y -= jump
			
	if Input.is_action_just_pressed("Dash") && dashing == false && notMoving == false:
		dash()

func speed_calc(delta): 
	Speed += acceleration * delta
	if Speed > maxSpeed:
		Speed = maxSpeed
		
func dash() -> void:
	##print("dash")
	dashing = true
	velocity.x = dashSpeed * direction
	yield(get_tree().create_timer(0.3), "timeout")
	dashing = false
	pass
