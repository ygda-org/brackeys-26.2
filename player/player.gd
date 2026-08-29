extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 1500
const DECELERATION = 3000
@export var acceleration_curve: Curve

var old_dir: Vector2 = Vector2(0,0)

var punch_vec = Vector2i(1,0)

func _ready():
	GameState.camera = $Camera2D
	GameState.player = self

func _physics_process(delta):
	if GameState.player_animation_lock:
		return
	if Input.is_action_just_pressed("open_application") and GameState.near_desk:
		if $CanvasLayer.visible:
			$CanvasLayer.visible = false
			GameState.main.get_node("CanvasModulate").visible = true
			pass
		else:
			$CanvasLayer.visible = true
			GameState.main.get_node("CanvasModulate").visible = false
			pass
		
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
	if not $PunchDur.is_stopped():
		velocity = Vector2.ZERO
	move_and_slide()
	$VisionArm.look_at(get_global_mouse_position())#rotation = lerpf($VisionArm.rotation, global_position.direction_to(get_global_mouse_position()).angle(), delta * 20)
	$PunchHitbox.rotation = Vector2(Vector2i(1.3*global_position.direction_to(get_global_mouse_position()))).angle()
	#if dir != Vector2(0,0):
		#$VisionArm.rotation = lerpf($VisionArm.rotation, dir.angle(), delta * 20)
	#$PunchHitbox.look_at(get_global_mouse_position())
	var anim_string
	var dir_save = dir
	if not dir:
		dir = old_dir
	anim_string = vec_to_string(dir)
	if not anim_string:
		return
	if Input.is_action_just_pressed("punch") and $PunchDur.is_stopped():
		get_tree().create_timer(0.4).timeout.connect($PunchHitbox.set.bind("monitoring", true))
		get_tree().create_timer(0.7).timeout.connect($PunchHitbox.set.bind("monitoring", false))
		$PunchDur.start()
		punch_vec = Vector2i(1.44*global_position.direction_to(get_global_mouse_position()))
		if not punch_vec:
			punch_vec = Vector2i(1,0)
		$Anim.play(vec_to_string(punch_vec) + "_punch")
		if "left" in $Anim.animation:
			$Anim.flip_h = true
	if not dir_save:
		anim_string += "_idle"
	if $PunchDur.is_stopped():
		$Anim.play(anim_string)
	old_dir = dir

func vec_to_string(dir):
	var anim_string
	if dir.y > 0:
		anim_string = "down"
	elif dir.y < 0:
		anim_string = "up"
	elif dir.x > 0:
		anim_string = "right"
	elif dir.x < 0:
		anim_string = "left"
	return anim_string

func _on_punch_hitbox_body_entered(body):
	body.fired()


func _on_employee_scan_body_entered(body):
	body.reset_motivation()


func _on_punch_dur_timeout():
	$Anim.flip_h = false
