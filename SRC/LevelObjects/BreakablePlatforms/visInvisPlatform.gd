extends Area2D

export var StartVisibility = 0.5
var spritevisible = false

func _ready():
	$Sprite.modulate.a = StartVisibility

func _on_Player_dashingSignal(is_dashing):
	print("is dashing", is_dashing)
	if(is_dashing):
		$Sprite.modulate.a = 1.0
		
		if($Sprite.modulate.a != 1.0):
			print("hiding")
			$Sprite.modulate.a = StartVisibility
			print($Sprite.modulate.a)
			spritevisible = false
