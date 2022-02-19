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
#	timer.start()
#	print("timer started")


func _on_Timer_timeout():
	pass
#	print("timer timedout")
#	var temp = collision_layer
#	collision_layer = 0
#	global_position = resetpos
#	yield(get_tree(), "physics_frame")
#	collision_layer = temp


func _on_AnimationPlayer_animation_finished():
	pass
	#print("animation is finished")
#	if anim_name == "animation_finished":
#		queue_free()
#		print("animation finished")
