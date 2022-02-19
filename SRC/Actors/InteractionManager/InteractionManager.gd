extends InteractionManager

export var timeLine = ""
export var dialogue_index = 0

#export var npc = ""

#func start_dialogue():
#	var dialogue = Dialogic.start(npc + str(dialogue_index))
#	dialogue.pause_mode = PAUSE_MODE_PROCESS
#	get_parent().add_child(dialogue)
	


func receive_interaction() -> void:
	print(timeLine)
	if get_node_or_null('DialogNode') == null and timeLine != "":
		if Input.is_action_pressed("ui_accept"):
			var dialog = Dialogic.start(timeLine)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			get_tree().paused = true
			after_dialogue()
			

func unpause(timeLine):
	get_tree().paused = false

#func end_dialogue(data):
#	get_tree().paused = false

func after_dialogue():
	print(dialogue_index)
	if dialogue_index < 2:
		dialogue_index += 1

	if dialogue_index == 1:
		timeLine = "Heey"
	
	if dialogue_index == 2:
		timeLine = "Test2"
		






	


	
