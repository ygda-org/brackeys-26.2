extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.tween_day.connect(appear)
	visible = false

func appear():
	visible = true
	$CenterContainer/Label.text = "Day " + str(GameState.day_num)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0)
	await tween.finished
	await get_tree().create_timer(2.0).timeout
	GameState.day_started.emit()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.7)
	await tween2.finished
	visible = false
