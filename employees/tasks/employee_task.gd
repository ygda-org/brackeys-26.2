extends Marker2D

class_name Task

enum TaskTypes {
	SABO,
	NEUTRAL,
	POS
}

@export var task_type: TaskTypes
@export var affect_amount: int = 0
@export var task_length: float = 10.0


func _ready():
	GameState.task_lists[task_type].append(self)
