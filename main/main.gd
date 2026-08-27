extends Node2D

func _ready():
	GameState.main = self
	await get_tree().process_frame
	GameState.day_started.emit()
