extends ParallaxLayer

export(float) var Cloud_Speed = -15
func _process(delta) -> void:
	self.motion_offset.x += Cloud_Speed * delta
