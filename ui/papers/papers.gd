extends Control

var current_app : Application = null
var processed_name : String
var processed_jobs : String
var processed_skills : String
var processed_college : String
var processed_reason : String
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
	processed_name=current_app.name.capitalize()
	processed_jobs=current_app.PastJobs.find_key(current_app.past_jobs[0]).capitalize() +" and "+current_app.PastJobs.find_key(current_app.past_jobs[1]).capitalize()
	processed_skills=current_app.Skills.find_key(current_app.skills[0]).capitalize() + ", "+current_app.Skills.find_key(current_app.skills[1]).capitalize()+ ", and "+ current_app.Skills.find_key(current_app.skills[2]).capitalize()
	processed_college=current_app.College.find_key(current_app.college).capitalize()
	processed_reason=current_app.CompanyReason.find_key(current_app.company_reason).capitalize()
	text += "Name: " + processed_name + "\n"
	text += "Past Jobs: " +processed_jobs+ "\n"
	text += "Skills: " + processed_skills + "\n"
	text += "College: " + processed_college + "\n"
	text += "Company Reason: " + processed_reason + "\n"
	$ApplicationText.text = text
	choose_portrait()

func choose_portrait():
	$TextureRect.texture = load(portraits[current_app.portrait_num])
		
	if GameState.last_portrait == null:
		GameState.last_portrait = current_app.portrait_num
	#elif current_app.portrait_num == GameState.last_portrait: # got rid of this since annoying
	#	choose_portrait()
	else:
		GameState.last_portrait = current_app.portrait_num

func _on_hire_button_pressed() -> void:
	GameState.hire()
	SFX.play(SFX.Id.HIRE)
	current_app = null


func _on_reject_button_pressed() -> void:
	SFX.play(SFX.Id.BEEP)
	GameState.hiring_queue.pop_front()
	current_app = null
func _on_handbook_button_pressed() -> void:
	GameState.player.display_book()
