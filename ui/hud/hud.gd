extends CanvasLayer

var pause: bool = false

func _ready():
	$DayTimer.max_value = GameState.DAY_LENGTH
	$DayTimer.value = GameState.DAY_LENGTH
	GameState.day_started.connect(set.bind("pause", false))

func _process(delta):
	if pause:
		return
	$DayTimer.value = $DayTimer.value - delta
	if $DayTimer.value < 0.1:
		pause = true
		GameState.day_ended.emit()
