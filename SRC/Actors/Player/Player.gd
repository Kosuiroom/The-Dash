extends KinematicBody2D

var velocity = Vector2(0,0)
export var maxSpeed : float = 600.0
export var acceleration : float = 200.0
export var jump = 900
export var gravity = 35
var moveSpeed = 180

export var dashSpeed = 1000
var dashing = false
var lerprate = 0.1
var direction = 0
var notMoving = true
onready var animation = $AnimationPlayer

func _physics_process(delta):

	#apply_gravity(delta)
	get_input(delta)
	##print(velocity.x)
	velocity.y = velocity.y + gravity;
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "MudCrawler":
			print("I collided with ", collision.collider.name)
	
#func apply_gravity(delta : float) -> void:
	

func get_input(delta):
	if Input.is_action_pressed("mvLeft"):
		animation.play("Running")
		$Grounder.flip_h = true
		direction = -1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,-moveSpeed,lerprate)
	elif Input.is_action_pressed("mvRight"):
		animation.play("Running")
		$Grounder.flip_h = false
		direction = 1
		notMoving = false
		speed_calc(delta)
		velocity.x = lerp(velocity.x,moveSpeed,lerprate)
	else:
		notMoving = true
		animation.play("Idle")
		moveSpeed = 0
		velocity.x = lerp(velocity.x,moveSpeed,lerprate)
		
	if is_on_floor():
		if Input.is_action_just_pressed("player_jump"):
			animation.play("Jump")
			velocity.y -= jump
			$Player_Jump.play()
		
			
	if Input.is_action_just_pressed("Dash") && dashing == false && notMoving == false:
		dash()

func speed_calc(delta): 
	moveSpeed += acceleration * delta
	if moveSpeed > maxSpeed:
		moveSpeed = maxSpeed
		
func dash() -> void:
	##print("dash")
	dashing = true
	velocity.x = dashSpeed * direction
	yield(get_tree().create_timer(0.3), "timeout")
	dashing = false
	pass
