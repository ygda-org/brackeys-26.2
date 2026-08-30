extends Node2D

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0)
	await tween.finished
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 2.0)
	tween2.tween_callback(queue_free)
