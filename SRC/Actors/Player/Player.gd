extends Actor

export var dashSpeed: = 1000.0

var dashing = false
var lerprate = 0.1
var notMoving = true
export var playerSpeed = Vector2(500,500)
signal _dashedInto(dashing)
#onready var animation = $AnimatedPlayer

func _physics_process(delta):
	var _direction: = get_direction()
	var is_jump_cancelled: = Input.is_action_just_released("jump") and velocity.y < 0.0
	
	velocity = calc_move_velocity(velocity,_direction, playerSpeed, is_jump_cancelled, dashing)
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if _direction != Vector2(0,0):
		#print("notmoving ", notMoving)
		notMoving = false
		if Input.is_action_just_pressed("Dash") && dashing == false && notMoving == false:
			dash()
	
	#if _direction == Vector2(1,0):
		#animation.play("Running")
		#$AnimatedPlayer.flip_h = false
	#elif _direction == Vector2(-1,0):
		#animation.play("Running")
		#$AnimatedPlayer.flip_h = true
		
func dash() -> void:
	#print("dash")
	dashing = true
	emit_signal("_dashedInto",dashing)
	pass
	
func get_direction() -> Vector2:
	return Vector2 (
		Input.get_action_strength("mvRight") - Input.get_action_strength("mvLeft"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calc_move_velocity(
		lin_velocity: Vector2,
		direction: Vector2,
		mvSpeed: Vector2,
		is_JumpCancelled: bool,
		is_dashing: bool
	) -> Vector2:
		
	var new_velocity: = lin_velocity
	new_velocity.x = lerp(new_velocity.x, mvSpeed.x * direction.x, lerprate)
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = mvSpeed.y * direction.y
	if is_JumpCancelled and not is_on_floor():
		new_velocity.y = 0.0
	if is_dashing:
		new_velocity.x = dashSpeed * direction.x
		dashing = false
	return new_velocity

#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		if collision.collider.name == "MudCrawler":
#			print("I collided with ", collision.collider.name)

#SIGNALS
func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Main.tscn")
