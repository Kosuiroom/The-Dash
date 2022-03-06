extends Actor

export var direction = 1
export var detectCliff = true
export var slimeSpeed = 50
var dash = false
var slimvol = Vector2.ZERO
export var SlimeHealth = 2

func _init():
	velocity = slimvol
	health = SlimeHealth
	print("slimehealth ", SlimeHealth)

func _ready():
	if direction == -1:
		$Sprite.flip_h = true
	$FloorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorCheck.enabled = detectCliff

func _physics_process(delta):
	if is_on_wall() or not $FloorCheck.is_colliding() and detectCliff and is_on_floor():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$FloorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y += 20
	
	velocity.x = slimeSpeed * direction
	
	move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout():
	queue_free()


#func _on_Player__dashedInto(dashing):
#	if dashing:
#		print("damaged slime")
#		SlimeHealth = tookDmg(SlimeHealth,1)
#
#	if SlimeHealth == 0:
#		slimeSpeed = 0
#		set_collision_layer_bit(1, false)
#		set_collision_mask_bit(0, false)
#		$dmgCheck.set_collision_layer_bit(1, false)
#		$dmgCheck.set_collision_mask_bit(0, false)
#		$Timer.start()

func _on_dmgCheck_body_entered(body):
	body.takeDmg()
