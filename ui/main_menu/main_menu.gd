extends Control

const button_grow_amount = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/Play.pressed.connect(button_pressed.bind($Menu/Play))
	$Menu/Settings.pressed.connect(button_pressed.bind($Menu/Settings))
	$Menu/Credits.pressed.connect(button_pressed.bind($Menu/Credits))
	
	$Menu/Play.mouse_entered.connect(button_entered.bind($Menu/Play))
	$Menu/Settings.mouse_entered.connect(button_entered.bind($Menu/Settings))
	$Menu/Credits.mouse_entered.connect(button_entered.bind($Menu/Credits))
	
	$Menu/Play.mouse_exited.connect(button_exited.bind($Menu/Play))
	$Menu/Settings.mouse_exited.connect(button_exited.bind($Menu/Settings))
	$Menu/Credits.mouse_exited.connect(button_exited.bind($Menu/Credits))
	
	$Fade.self_modulate = Color(0,0,0,0)
	$YGDAIntro/YGDAIntroAnimPlayer.play("ygda_intro")
	SFX.play(SFX.Id.YGDA_STING)

func button_pressed(button : Button):
	SFX.play(SFX.Id.BUTTON_CLICK)
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1 - button_grow_amount,1 - button_grow_amount), 0.025)
	tween.tween_interval(0.1)
	tween.tween_property(button, "scale", Vector2(1,1), 0.025)
	SFX.play(SFX.Id.BUTTON_CLICK)
	await get_tree().create_timer(0.25).timeout
	
func button_entered(button : Button):
	SFX.play(SFX.Id.BUTTON_HOVER)
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1 + button_grow_amount,1 + button_grow_amount), 0.05)


func button_exited(button : Button):
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1.0,1.0), 0.05)

func fade_out(seconds : int):
	$Fade.self_modulate = Color(0,0,0,0)
	var tween = $Fade.create_tween()
	tween.tween_property($Fade, "self_modulate", Color(0,0,0,1),seconds)


func _on_play_pressed():
	fade_out(1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://b7hx7eym7wpfj")

func _on_settings_pressed():
	fade_out(1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("uid://c81oaw6kaqufp")
