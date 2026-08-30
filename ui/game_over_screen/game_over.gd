extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = $Fade.create_tween()
	tween.tween_property($Fade, "self_modulate", Color(0,0,0,0),1.0)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.seek(0)
	$AudioStreamPlayer.playing = true
