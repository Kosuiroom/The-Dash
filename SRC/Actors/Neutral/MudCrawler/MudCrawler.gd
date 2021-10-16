extends KinematicBody2D

export var direction = 1

var velocity = Vector2()
var speed = 50

func _ready():
	if direction == -1:
		$Sprite.flip_h = true


func _physics_process(delta):

	if is_on_wall():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h

	velocity.y += 20
	
	velocity.x = speed * direction
		
	move_and_slide(velocity, Vector2.UP)
