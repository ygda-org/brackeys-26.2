extends CharacterBody2D

var application: Application

func fired():
	var tween1 = get_tree().create_tween()
	tween1.tween_property(GameState.camera, "zoom", Vector2(5,5), 1.0).set_trans(Tween.TRANS_QUINT)
