extends Control

func _ready():
	$Fade.self_modulate = Color(0,0,0,0)
	
	$VolumeGrid/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$VolumeGrid/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$VolumeGrid/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$VolumeGrid/AmbienceSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Ambience")))

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
	
func fade_out(seconds : int):
	$Fade.self_modulate = Color(0,0,0,0)
	var tween = $Fade.create_tween()
	tween.tween_property($Fade, "self_modulate", Color(0,0,0,1),seconds)

func _on_return_button_pressed():
	fade_out(1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://chx5r6nxm8j6b")
