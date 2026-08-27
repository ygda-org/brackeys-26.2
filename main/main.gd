extends Node2D

func _ready():
	await get_tree().process_frame
	GameState.day_started.emit()
