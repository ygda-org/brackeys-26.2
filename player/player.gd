extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 1500
const DECELERATION = 3000
@export var acceleration_curve: Curve

var old_dir: Vector2 = Vector2(0,0)

func _ready():
	GameState.camera = $Camera2D
	GameState.player = self

func _physics_process(delta):
	if GameState.player_animation_lock:
		return
	if Input.is_action_just_pressed("punch"):
		$PunchHitbox.monitoring = true
		get_tree().create_timer(0.25).timeout.connect($PunchHitbox.set.bind("monitoring", false))
	var dir = Input.get_vector("left", "right", "up", "down")
	if dir.x:
		velocity.x = move_toward(velocity.x, dir.x * MAX_SPEED, ACCELERATION * delta * acceleration_curve.sample(abs(velocity.x)/MAX_SPEED))
		if dir.x * velocity.x < 0:
			velocity.x = move_toward(velocity.x, 0.0, DECELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, DECELERATION * delta)
	if dir.y:
		velocity.y = move_toward(velocity.y, dir.y * MAX_SPEED, ACCELERATION * delta * acceleration_curve.sample(abs(velocity.y)/MAX_SPEED))
		if dir.y * velocity.y < 0:
			velocity.y = move_toward(velocity.y, 0.0, DECELERATION * delta)
	else:
		velocity.y = move_toward(velocity.y, 0.0, DECELERATION * delta)
	velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
	$VisionArm.look_at(get_global_mouse_position())
	$PunchHitbox.look_at(get_global_mouse_position())
	var anim_string
	var dir_save = dir
	if not dir:
		dir = old_dir
	if dir.y > 0:
		anim_string = "down"
	elif dir.y < 0:
		anim_string = "up"
	elif dir.x > 0:
		anim_string = "right"
	elif dir.x < 0:
		anim_string = "left"
	if not anim_string:
		return
	if not dir_save:
		anim_string += "_idle"
	$Anim.play(anim_string)
	old_dir = dir

func _on_punch_hitbox_body_entered(body):
	body.fired()


func _on_employee_scan_body_entered(body):
	body.reset_motivation()
