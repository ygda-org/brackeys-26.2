extends Control

var current_app : Application = null

var portraits = {
	1 : "uid://lkp81lwlj61h",
	2 : "uid://dwynkhhna46jx",
	3 : "uid://uyut62piu15r",
	4 : "uid://b1hqjste1mkfw",
	5 : "uid://bosottpmmxukb",
	6 : "uid://cg23r42rk6aij",
	7 : "uid://c4ubm2ecwpvr",
}
var portraits_masc = {
	1 : "res://assets/characters/portraits/portrait_2.PNG",
	2 : "res://assets/characters/portraits/portrait_4.PNG",
	3 : "res://assets/characters/portraits/portrait_7.PNG"
}
var portraits_fem = {
	1 : "res://assets/characters/portraits/portrait_1.PNG",
	2 : "res://assets/characters/portraits/portrait_3.PNG",
	3 : "res://assets/characters/portraits/portrait_5.PNG",
	4 : "res://assets/characters/portraits/portrait_6.PNG"
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
	if(current_app.gender==0):
		$TextureRect.texture = load(portraits[randi_range(1,7)])
	elif(current_app.gender==1):
		$TextureRect.texture = load(portraits_masc[randi_range(1,3)])
	elif(current_app.gender==2):
		$TextureRect.texture = load(portraits_fem[randi_range(1,4)])

func _on_hire_button_pressed() -> void:
	GameState.hire()
	current_app = null


func _on_reject_button_pressed() -> void:
	GameState.hiring_queue.pop_front()
	current_app = null
