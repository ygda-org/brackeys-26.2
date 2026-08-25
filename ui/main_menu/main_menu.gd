extends Control

const button_grow_amount = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	
	ygda_intro()
	
	$Menu/Play.pressed.connect(button_pressed.bind($Menu/Play))
	$Menu/Settings.pressed.connect(button_pressed.bind($Menu/Settings))
	$Menu/Credits.pressed.connect(button_pressed.bind($Menu/Credits))
	
	$Menu/Play.mouse_entered.connect(button_entered.bind($Menu/Play))
	$Menu/Settings.mouse_entered.connect(button_entered.bind($Menu/Settings))
	$Menu/Credits.mouse_entered.connect(button_entered.bind($Menu/Credits))
	
	$Menu/Play.mouse_exited.connect(button_exited.bind($Menu/Play))
	$Menu/Settings.mouse_exited.connect(button_exited.bind($Menu/Settings))
	$Menu/Credits.mouse_exited.connect(button_exited.bind($Menu/Credits))

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

func ygda_intro():
	var ygda_logo = $YGDAIntro/YGDALogo
	var color_rect = $YGDAIntro/ColorRect
	ygda_logo.visible = true
	color_rect.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	SFX.play(SFX.Id.YGDA_STING)
	var tween_opening = get_tree().create_tween()
	tween_opening.tween_property(color_rect, "self_modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(1.41).timeout
	ygda_logo.play("default")
	await get_tree().create_timer(2.59).timeout
	var tween_closing = get_tree().create_tween()
	tween_closing.tween_property(color_rect, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0).set_trans(Tween.TRANS_SINE)
	tween_closing.parallel().tween_property(color_rect, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(1.41).timeout 
	ygda_logo.visible = false
