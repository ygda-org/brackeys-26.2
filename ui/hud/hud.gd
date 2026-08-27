extends Control

func _ready():
	$DayTimer.max_value = GameState.day_length
	$DayTimer.value = GameState.day_length

func _process(delta):
	$DayTimer.value -= delta
	if $DayTimer.value < 0.1:
		GameState.day_ended.emit()
