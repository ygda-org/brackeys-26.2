extends Node

const EMPLOYEE = preload("uid://cmbb1fu0dvb01")

const DAY_LENGTH = 60.0
const START_DAY_HIRING_QUOTA = 5

var day_num: int = 1

signal day_started
signal day_ended
signal tween_day

signal hire_failed

signal day_failed

var pause: bool = false

var camera: Camera2D
var main: Node2D

var player: CharacterBody2D

var near_desk : bool = false

## application accessible by Employee.application
var employees_list: Array[Employee]
var fired_amount: int = 0

var player_animation_lock: bool = false

var sabo_task_list: Array[Task] = []
var neutral_task_list: Array[Task] = []
var pos_task_list: Array[Task] = []
## sabo, neutral, pos
@onready var task_lists = [sabo_task_list, neutral_task_list, pos_task_list]

var home_positions = []

var productivity_points: int = 0
var production_requirement: float = 25

var hiring_quota_remaining: int = START_DAY_HIRING_QUOTA
var hiring_queue: Array[Application]
var application_amount: int = 35

var last_portrait : int

func _ready():
	day_started.connect(start_day)
	day_failed.connect(game_over)
	day_ended.connect(end_day)

func start_day():
	player_animation_lock = false
	fired_amount = 0
	set_deferred("pause", false)
	hiring_queue = []
	hiring_quota_remaining = START_DAY_HIRING_QUOTA
	productivity_points = 0
	for i in range(application_amount):
		hiring_queue.append(ApplicationHandler.create_application())

func end_day():
	pause = true
	if fired_amount < START_DAY_HIRING_QUOTA:
		for i in range(START_DAY_HIRING_QUOTA-fired_amount):
			if not employees_list:
				break
			var index = randi_range(0, employees_list.size()-1)
			var employee = employees_list[index]
			employees_list.remove_at(index)
			if employee and employee.home_position:
				employee.home_position.is_open = true
			employee.queue_free()
	# hire new if not filled
	if hiring_quota_remaining > 0:
		for i in range(hiring_quota_remaining):
			hire()
			await get_tree().create_timer(0.5).timeout
	player_animation_lock = true
	day_num += 1
	tween_day.emit()

func hire():
	if hiring_quota_remaining <= 0:
		hire_failed.emit()
		return
	var app = hiring_queue.pop_front()
	var employee = EMPLOYEE.instantiate()
	employee.application = app
	main.add_child(employee)
	hiring_quota_remaining -= 1

func get_open_home_position():
	for pos in home_positions:
		if pos.is_open:
			pos.is_open = false
			return pos

func game_over():
	get_tree().change_scene_to_file("uid://bm863q8bmboqi")
