extends KinematicBody2D

onready var interactionManager: InteractionManager = $"Interaction"

func _ready():
	pass






























"""export var NPC = "npc name"
export var dialogue_index = 0

func _ready():
	add_to_group("NPC")


func start_dialogue():
	var dialogue = Dialogic.start(NPC + str(dialogue_index))
	get_parent().add_child(dialogue)
	dialogue.connect("timeline_end", self, "end_dialogue")"""
	







"""var active = false

func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")
	
	
func _input(event):
	if get_node_or_null("Dialogue") == null:
		if event.is_action_pressed ("ui_accept") and active:
			#Freeze the game while in a dialogue
			#get_tree().paused = true
			var dialogue = Dialogic.start("Test")
			dialogue.pause_mode = Node.PAUSE_MODE_PROCESS
			dialogue.connect("timeline_end", self, "unpause")
			add_child(dialogue)
	
func unpause(timeline_name):
	get_tree().paused = false

	
func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
	
	
func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false"""
