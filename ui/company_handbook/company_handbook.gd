extends Control

var current_page = 0
var max_page = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#$Page/LeftPageContent.get_child(0).visible = false
	#for i in $Page/LeftPageContent.get_child_count():
		#$Page/LeftPageContent.get_child(i).visible = false
		#
	#match current_page:
		#0: 
			#$Page/LeftPageContent/PageZero.visible = true
		#1: 
			#$Page/LeftPageContent/PageOne.visible = true
		#2: 
			#$Page/LeftPageContent/PageTwo.visible = true
			#
#func _on_left_pressed():
	#if current_page <= 0:
		#return
	#current_page -= 1
	#$AnimationPlayer.play("flip_backwards")
	#await $AnimationPlayer.animation_finished
	#reset_scale()
		#
#func _on_right_pressed():
	#if current_page >= max_page:
		#return
	#$AnimationPlayer.play("flip_forwards")
	#await $AnimationPlayer.animation_finished
	#current_page += 1
	#
#func reset_scale():
	#$Page.scale = Vector2(1.0,1.0)
