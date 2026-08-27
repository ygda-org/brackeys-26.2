extends Node

const DAY_LENGTH = 10.0

signal day_started
signal day_ended

var camera: Camera2D

## application accessible by Employee.application
var employees_list: Array[Employee]

var player_animation_lock: bool = false

var sabo_task_list: Array[Task] = []
var neutral_task_list: Array[Task] = []
var pos_task_list: Array[Task] = []
## sabo, neutral, pos
@onready var task_lists = [sabo_task_list, neutral_task_list, pos_task_list]

var home_positions = []

var productivity_points: int = 0

func _ready():
	day_started.connect(start_day)

func start_day():
	productivity_points = 0

func get_open_home_position():
	for pos in home_positions:
		if pos.is_open:
			return pos
