extends Resource
class_name Application

enum PastJobs {
	PENGUIN
}

enum Skills {
	PENGUIN
}

@export var person_name: String
@export var past_jobs: Array[PastJobs]
@export var skills: Array[Skills]
@export var company_reason: String
