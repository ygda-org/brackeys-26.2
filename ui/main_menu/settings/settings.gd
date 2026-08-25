extends Control

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


func _on_button_pressed():
	get_tree().change_scene_to_file("uid://chx5r6nxm8j6b")
