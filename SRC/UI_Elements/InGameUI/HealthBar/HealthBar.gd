extends AnimatedSprite

func _on_Player_health_update(playerHealth):
	print("updated health")
#	healthbar.value = playerHealth
	if playerHealth == 3:
		self.set_frame(0)
		self.get_animation()
	elif playerHealth == 2:
		self.set_frame(1)
	elif playerHealth == 1:
		self.set_frame(2)
	elif playerHealth == 0:
		self.set_frame(3)
