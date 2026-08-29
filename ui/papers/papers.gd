extends Control

var current_app : Application = null

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


func _on_hire_button_pressed() -> void:
	GameState.hire()
	current_app = null


func _on_reject_button_pressed() -> void:
	GameState.hiring_queue.pop_front()
	current_app = null
