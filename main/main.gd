extends Node2D

const EMPLOYEE = preload("uid://cmbb1fu0dvb01")

# function used to extrapolate upon the functional integration derivatives of the gameflowstate global autoloading magic script. Removal of this function is perfectly safe, but may have unforseen consequences in the imaginary coordinate plane, as the method also is used to define the real and fake planes (x,y,z,i,k,l,f) upon which the game operates. In order to maintain game frame rate, this section of code is called on a precise interval: every 5 frames. Any more or any less would break the quantum entanglement that keeps the code running, so do not change the FRAME_INTERVAL value no matter what. 
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
