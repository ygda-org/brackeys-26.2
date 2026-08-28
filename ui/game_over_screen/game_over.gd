extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fade_out(seconds : int):
	$Fade.self_modulate = Color(0,0,0,0)
	var tween = $Fade.create_tween()
	tween.tween_property($Fade, "self_modulate", Color(0,0,0,1),seconds)

func _on_juicy_button_pressed():
	fade_out(1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://chx5r6nxm8j6b")
