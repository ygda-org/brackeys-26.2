extends Control

var current_app : Application = null

var portraits = {
	1 : "uid://c4ubm2ecwpvr",
	2 : "uid://b1hqjste1mkfw",
	3 : "uid://dwynkhhna46jx",
	4 : "uid://lkp81lwlj61h",
	5 : "uid://uyut62piu15r",
	6 : "uid://bosottpmmxukb",
	7 : "uid://cg23r42rk6aij",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_app == null and GameState.hiring_queue.size() > 0:
		load_application()

func load_application():
	current_app = GameState.hiring_queue[0]
	var text : String = ""
	text += "Name: " + current_app.name + "\n"
	text += "Past Jobs: " + str(current_app.past_jobs) + "\n"
	text += "Skills: " + str(current_app.skills) + "\n"
	text += "College: " + str(current_app.college) + "\n"
	text += "Company Reason: " + str(current_app.company_reason) + "\n"
	$ApplicationText.text = text
	choose_portrait()

func choose_portrait():
	print("gamble")
	
	var current_portrait : int = 0
	
	if(current_app.gender==0):
		current_portrait = randi_range(1,7)
		$TextureRect.texture = load(portraits[current_portrait])
	elif(current_app.gender==1):
		current_portrait = randi_range(1,3)
		$TextureRect.texture = load(portraits[current_portrait])
	elif(current_app.gender==2):
		current_portrait = randi_range(4, 7)
		$TextureRect.texture = load(portraits[current_portrait])
		
	if GameState.last_portrait == null:
		GameState.last_portrait = current_portrait

	elif current_portrait == GameState.last_portrait:
		choose_portrait()
	else:
		GameState.last_portrait = current_portrait

func _on_hire_button_pressed() -> void:
	GameState.hire()
	current_app = null


func _on_reject_button_pressed() -> void:
	GameState.hiring_queue.pop_front()
	current_app = null
