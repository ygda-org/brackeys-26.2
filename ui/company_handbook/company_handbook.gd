extends Control

var current_page = 0
var max_page = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_pressed():
	if current_page <= 0:
		return
	current_page -= 1
	$AnimationPlayer.play("flip_backwards")
		
func _on_right_pressed():
	if current_page >= max_page:
		return
	current_page += 1
	$AnimationPlayer.play("flip_forwards")
