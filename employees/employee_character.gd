extends CharacterBody2D
class_name Employee

signal motivation_reset

var application: Application

const SPEED = 200

var max_motivation: int = 4
## motivation is the number of positive tasks an employee will do without the watchful gaze of their superviser to reset them
@onready var motivation: int = max_motivation

## every employee has a home position (like their desk) which they return to after finishing a task
var home_position: Marker2D

var current_task: Task

@export var is_initial_employee: bool = false

func _ready():
	position = Vector2(1000,0)
	GameState.employees_list.append(self)
	await get_tree().process_frame
	home_position = GameState.get_open_home_position()
	GameState.day_started.connect(_on_day_start)
	GameState.day_ended.connect($TaskIntermission.stop)
	GameState.day_ended.connect($InTask.stop)

func _physics_process(_delta):
	if $NavigationAgent2D.is_navigation_finished():
		if $InTask.is_stopped() and current_task: # start task
			$InTask.wait_time = current_task.task_length
			$InTask.start()
		return
	var agent_position: Vector2 = global_position
	var next_position: Vector2 = $NavigationAgent2D.get_next_path_position()
	
	velocity = Vector2.ZERO
	velocity = agent_position.direction_to(next_position) * SPEED
	var side_clear = not check_wall_casts(sign(velocity.x), "Side")
	var vert_clear = not check_wall_casts(sign(velocity.y), "Vert")
	var side_issue: bool = false
	if abs(velocity.x) > abs(velocity.y) and side_clear:
		velocity.y = 0
	elif abs(velocity.x) <= abs(velocity.y) and vert_clear:
		velocity.x = 0
	else:
		side_issue = true
	if side_issue:
		if side_clear:
			velocity.y = 0
		elif vert_clear:
			velocity.x = 0
		else:
			print('I give up')
	velocity = velocity.normalized() * SPEED
	move_and_slide()

## dir should be 1 or -1, side should be "Side" or "Vert"
func check_wall_casts(dir: int, side: String):
	for node: RayCast2D in get_node(side + "WallCheckCasts").get_children():
		if not dir:
			break
		node.target_position = abs(node.target_position) * dir
		node.force_raycast_update()
		if node.is_colliding():
			return true
	return false

func _on_day_start():
	reset_motivation()
	$TaskIntermission.wait_time = randf_range(5,15)
	$TaskIntermission.start()
	position = home_position.position

func reset_motivation():
	motivation = max_motivation
	motivation_reset.emit()

func do_sabotage():
	$NavigationAgent2D.target_position = get_sabotage_target_position()
	await $NavigationAgent2D.navigation_finished
	# hurt company
	$NavigationAgent2D.target_position = home_position

func do_neutral_task():
	$NavigationAgent2D.target_position = get_neutral_target_position()
	await $NavigationAgent2D.navigation_finished
	$NavigationAgent2D.target_position = home_position

## returns a position for an employee to go to for sabotage
func get_sabotage_target_position():
	return GameState.sabo_task_list.pick_random()

## returns a position for an employee to get up and go to, like a water cooler
func get_neutral_target_position():
	return Vector2(0,0)

func fired():
	GameState.player_animation_lock = true
	var tween1 = get_tree().create_tween()
	tween1.set_parallel()
	tween1.set_trans(Tween.TRANS_CUBIC)
	tween1.set_ease(Tween.EASE_OUT)
	tween1.tween_property(GameState.camera, "zoom", Vector2(4.5,4.5), 1.0)
	tween1.tween_property(GameState.camera, "global_position", global_position, 0.8)
	await tween1.finished
	var tween2 = get_tree().create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_parallel()
	tween2.tween_property(GameState.camera, "zoom", Vector2(2.5,2.5), 0.3)
	tween2.tween_property(GameState.camera, "global_position", GameState.camera.get_parent().global_position, 0.3)
	await tween2.finished
	GameState.employees_list.remove_at(GameState.employees_list.find(self))
	GameState.player_animation_lock = false
	queue_free()




func _on_task_intermission_timeout():
	current_task = get_sabotage_target_position()
	$NavigationAgent2D.target_position = current_task.position


func _on_in_task_timeout():
	current_task = null
	motivation -= 1
	GameState.productivity_points += 15
	$NavigationAgent2D.target_position = home_position.position
	start_intermission()

func start_intermission():
	$TaskIntermission.wait_time = randf_range(25, 40) - motivation * 5
	$TaskIntermission.start()
