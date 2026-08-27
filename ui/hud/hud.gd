extends CanvasLayer

var pause: bool = false

func _ready():
	$DayTimer.max_value = GameState.DAY_LENGTH
	$DayTimer.value = GameState.DAY_LENGTH
	GameState.day_started.connect(_on_day_started)
	

func _process(delta):
	if pause:
		visible = false
		return
	else:
		visible = true
	$HiringAmount.text = "Need to hire: " + str(GameState.hiring_quota_remaining) + " more"
	$QuotaBar.value = GameState.productivity_points
	$DayTimer.value = $DayTimer.value - delta
	if $DayTimer.value < 0.1:
		pause = true
		if GameState.productivity_points < GameState.production_requirement:
			GameState.day_failed.emit()
		else:
			GameState.day_ended.emit()

func _on_day_started():
	pause = false
	$QuotaBar.max_value = GameState.production_requirement
