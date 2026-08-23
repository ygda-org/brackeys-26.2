extends CharacterBody2D
class_name Employee

var application: Application
## every employee has a home position (like their desk) which they return to after finishing a task
var home_position: Vector2 = Vector2(0,0)

const SPEED = 200

var max_motivation: int
## motivation is the number of positive tasks an employee will do without the watchful gaze of their superviser to reset them
@onready var motivation: int = max_motivation

func _ready():
	GameState.employees_list.append(self)

func _physics_process(_delta):
	if $NavigationAgent2D.is_navigation_finished():
		return
	var agent_position: Vector2 = global_position
	var next_position: Vector2 = $NavigationAgent2D.get_next_path_position()

	velocity = agent_position.direction_to(next_position) * SPEED
	move_and_slide()

func reset_motivation():
	motivation = max_motivation

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
	return Vector2(0,0)

## returns a position for an employee to get up and go to, like a water cooler
func get_neutral_target_position():
	return Vector2(0,0)

func fired():
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
	queue_free()
