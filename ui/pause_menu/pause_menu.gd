extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused == true:
		SFX.unpause_all(true, 10.0)
		visible = false
		get_tree().paused = false
		print("unpause")
		
	elif get_tree().paused == false:
		SFX.pause_all(true, 10.0)
		visible = true
		get_tree().paused = true
		print("pause")
		

func _on_unpause_button_pressed():
	toggle_pause()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("uid://chx5r6nxm8j6b")
	
func _on_master_slider_value_changed(value):
	change_bus_volume("Master", value)

func _on_music_slider_value_changed(value):
	change_bus_volume("Music", value)

func _on_sfx_slider_value_changed(value):
	change_bus_volume("SFX", value)

func _on_ambience_slider_value_changed(value):
	change_bus_volume("Ambience", value)

func change_bus_volume(bus, linear_value):
	var db_value = linear_to_db(linear_value)
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, db_value)
