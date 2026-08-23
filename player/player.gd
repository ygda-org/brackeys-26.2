extends CharacterBody2D

const MAX_SPEED = 600

func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * MAX_SPEED
	move_and_slide()
	$VisionArm.look_at(get_global_mouse_position())
