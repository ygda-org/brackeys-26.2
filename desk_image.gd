extends Sprite2D

func _on_area_2d_area_entered(area):
	if area.get_collision_layer() == 16:
		self.z_index = -1
	elif area.get_collision_layer() == 32:
		self.z_index = 1
