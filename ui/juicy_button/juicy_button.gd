class_name JuicyButton extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(juicy_pressed.bind(self))
	self.mouse_entered.connect(juicy_entered.bind(self))
	self.mouse_exited.connect(juicy_exited.bind(self))
	
	pivot_offset_ratio = Vector2(0.5,0.5)

func juicy_pressed(button : Button):
	SFX.play(SFX.Id.BUTTON_CLICK)
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1 - 0.05,1 - 0.05), 0.025)
	tween.tween_interval(0.1)
	tween.tween_property(button, "scale", Vector2(1,1), 0.025)
	SFX.play(SFX.Id.BUTTON_CLICK)
	await get_tree().create_timer(0.25).timeout
	
func juicy_entered(button : Button):
	SFX.play(SFX.Id.BUTTON_HOVER)
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1 + 0.05,1 + 0.05), 0.05)

func juicy_exited(button : Button):
	var tween : Tween = button.create_tween()
	tween.tween_property(button, "scale", Vector2(1.0,1.0), 0.05)
