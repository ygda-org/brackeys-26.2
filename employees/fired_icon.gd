extends Sprite2D

func _ready():
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.8)
	tween.tween_callback(queue_free)
