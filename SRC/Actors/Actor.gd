extends KinematicBody2D
class_name Actor

var velocity
var speed: = 0.0
var jump: = 0.0
var health = 0
export var gravity = 500


func tookDmg(var ActorHealth, var damageTaken):
	var newHealth = ActorHealth - damageTaken
	print("actor took: ", damageTaken)
	print("actors health is: ", newHealth)
	return newHealth
