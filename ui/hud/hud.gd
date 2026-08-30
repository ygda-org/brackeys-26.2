extends CanvasLayer

func _ready():
	$DayTimer.max_value = GameState.DAY_LENGTH
	$DayTimer.value = GameState.DAY_LENGTH
	GameState.day_started.connect(_on_day_started)

func _process(delta):
	$Panel/HiringAmount.text = "Need to hire: " + str(GameState.hiring_quota_remaining) + " more"
	$Panel/AppsRemaining.text = "Applications remaining: " + str(GameState.hiring_queue.size())
	$QuotaBar.value = GameState.productivity_points
	$DayTimer.value = $DayTimer.value - delta
	if $DayTimer.value < 0.1 and not GameState.pause:
		if GameState.productivity_points < GameState.production_requirement:
			GameState.day_failed.emit()
		else:
			GameState.day_ended.emit()

func _on_day_started():
	visible = true
	$DayTimer.value = GameState.DAY_LENGTH
	$QuotaBar.value = 0.0
	$QuotaBar.max_value = GameState.production_requirement
