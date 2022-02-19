# Character that moves and jumps.
class_name Player
extends Actor

export var PlayerSpeed := 200.0
export var PlayerJump := 200.0
export(int) var MaxHealth := 3
export var dashSpeed: = 500.0

var NO_SLOPE = 64.0
var DashAmount

onready var fsm := $StateMachine
onready var label := $Label
onready var dashTimer := $dash_timer
onready var Invulnerability_Timer := $Invulnerability_Timer
onready var JumpSound := $SoundJump
onready var healthbar := $HealthBar
onready var playerHealth = MaxHealth setget _set_health
signal health_update(playerHealth)
#onready var interactionManager: InteractionManager = $"Interaction"

func _init():
	speed = PlayerSpeed
	jump = PlayerJump
	DashAmount = 1

func _process(_delta: float) -> void:
	label.text = fsm.state.name

func damage(amount):
	if Invulnerability_Timer.is_stopped():
		Invulnerability_Timer.start()
		_set_health(playerHealth - amount)
		print("player took health")


func kill():
	print("player died")
	pass
	
func _set_health(value):
	print("health value: ", value)
	var prev_health = playerHealth
	print("prev health: ", prev_health)
	playerHealth = clamp(value, 0, MaxHealth)
	print("player health ", playerHealth)
	
	if playerHealth != prev_health:
		emit_signal("health_update", playerHealth)
		if playerHealth <= 0:
			kill()


func takeDmg(var enemyPosx):
	damage(1)
	
#func _unhandled_input(_event) -> void:
#		if Input.is_action_just_pressed("ui_accept"):
#			interactionManager.initiate_interaction()

##SIGNALS
func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Main.tscn")
