extends Node2D

const EMPLOYEE = preload("uid://cmbb1fu0dvb01")

func _ready():
	GameState.main = self
	await get_tree().process_frame
	for i in range(8):
		var employee = EMPLOYEE.instantiate()
		employee.application = ApplicationHandler.create_application()
		employee.is_initial_employee = true
		add_child(employee)
	await get_tree().process_frame
	GameState.day_started.emit()
