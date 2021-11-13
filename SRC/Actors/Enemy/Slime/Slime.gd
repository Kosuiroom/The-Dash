extends Actor

export var direction = 1
export var detectCliff = true

func _ready():
	if direction == -1:
		$Sprite.flip_h = true
	$FloorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorCheck.enabled = detectCliff

func _physics_process(delta):
	speed = Vector2(50,0)
	if is_on_wall() or not $FloorCheck.is_colliding() and detectCliff and is_on_floor():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$FloorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y += 20
	
	velocity.x = speed.x * direction
	
	move_and_slide(velocity, Vector2.UP)
