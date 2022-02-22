extends Area2D

onready var timer = $Timer
onready var resetpos = global_position

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("Destroyed")
			yield($AnimationPlayer, "animation_finished")
			queue_free()
		else:
			$AnimationPlayer.play("Idle")
