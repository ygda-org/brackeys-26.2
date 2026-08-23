extends CharacterBody2D
class_name Employee

var application: Application

func _ready():
	GameState.employees_list.append(self)

func fired():
	var tween1 = get_tree().create_tween()
	tween1.set_parallel()
	tween1.set_trans(Tween.TRANS_CUBIC)
	tween1.set_ease(Tween.EASE_OUT)
	tween1.tween_property(GameState.camera, "zoom", Vector2(4.5,4.5), 1.0)
	tween1.tween_property(GameState.camera, "global_position", global_position, 0.8)
	await tween1.finished
	var tween2 = get_tree().create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_parallel()
	tween2.tween_property(GameState.camera, "zoom", Vector2(2.5,2.5), 0.3)
	tween2.tween_property(GameState.camera, "global_position", GameState.camera.get_parent().global_position, 0.3)
	await tween2.finished
	GameState.employees_list.remove_at(GameState.employees_list.find(self))
	queue_free()
