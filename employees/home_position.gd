extends Marker2D

var is_open: bool = true

func _ready():
	GameState.home_positions.append(self)
