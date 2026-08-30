extends Control

const button_grow_amount = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	$Fade.self_modulate = Color(0,0,0,0)
	$YGDAIntro/YGDAIntroAnimPlayer.play("ygda_intro")
	SFX.play(SFX.Id.YGDA_STING)

func fade_out(seconds : int):
	$Fade.self_modulate = Color(0,0,0,0)
	var tween = $Fade.create_tween()
	tween.tween_property($Fade, "self_modulate", Color(0,0,0,1),seconds)

func _on_play_button_pressed():
	fade_out(1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://b7hx7eym7wpfj")


func _on_settings_button_pressed():
	$Settings.visible = true


func _on_credits_button_pressed():
	$Credits.visible = true


func _on_audio_stream_player_finished():
	$AudioStreamPlayer2.start()
