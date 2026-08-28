extends Sprite2D

@onready var char_num: String = str(randi_range(1,2))

var direction = Vector2i.ZERO
var old_direction = Vector2i.ZERO

const REGIONS = {Vector2i(1,0): 128, Vector2i(-1,0): 128,
Vector2i(0,1): 0, Vector2i(0,-1): 256}

func _ready():
	texture = load("res://assets/characters/sprites/portrait " + char_num + " walk.png")

func _process(_delta):
	flip_h = direction.x < 0
	if not direction == old_direction:
		var new_region
		if direction in REGIONS.keys():
			new_region = REGIONS[direction]
		else:
			new_region = REGIONS[old_direction]
		if direction:
			if $Timer.is_stopped():
				$Timer.start()
			new_region += 16
		else:
			$Timer.stop()
		region_rect.position.x = new_region
	old_direction = direction

func _on_timer_timeout():
	region_rect.position.x += 16
	if check_anim_loop():
		region_rect.position.x -= 64

func check_anim_loop():
	var pos = region_rect.position.x 
	return (pos > 60 and pos < 120) or (pos > 185 and pos < 250)
