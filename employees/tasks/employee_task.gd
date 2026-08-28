class_name Task extends Marker2D

enum TaskTypes {
	SABO,
	NEUTRAL,
	POS
}

@export var task_type: TaskTypes
@export var affect_amount: int = 0
@export var task_length: float = 10.0

var is_occupied: bool = false


func _ready():
	GameState.task_lists[task_type].append(self)
