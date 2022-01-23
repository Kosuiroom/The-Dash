# Character that moves and jumps.
class_name Player
extends Actor

export var PlayerSpeed := 500.0
export var PlayerJump := 500.0
export var PlayerHealth := 5
export var dashSpeed: = 1000.0

var dashing := false
var NO_SLOPE = 64.0
var DashAmount = 1

onready var fsm := $StateMachine
onready var label := $Label
onready var dashTimer := $dash_timer

#onready var interactionManager: InteractionManager = $"Interaction"

func _init():
	speed = PlayerSpeed
	jump = PlayerJump
	health = PlayerHealth
	
func _ready():
	dashTimer.connect("timeout", self,"dash_timer_timeout")



func _process(_delta: float) -> void:
	label.text = fsm.state.name
	
	
#func _unhandled_input(_event) -> void:
#		if Input.is_action_just_pressed("ui_accept"):
#			interactionManager.initiate_interaction()

##SIGNALS
func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Main.tscn")
