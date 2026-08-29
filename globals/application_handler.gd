extends Node
var unique_skill_count : int
var evil_modifier : int
var first_name : String
var last_name : String
var give_job : int
var give_skills : int
var give_college : int
var give_reason : int
var accepted : Array[bool] = [false,false,false,false] #amount of falses equal to amount of custom characters
func create_application():
	var app=Application.new()
	#check for special name
	var choice: int
	if (randi_range(0, 99)<3):
		choice=randi_range(0,3) #second number=amount of custom characters-1
		if(choice==0 and accepted[0]==false): #Hatsune Miku
			accepted[0]=true
			app=load("res://employees/applications/special applications/miku.tres")
			return app
		elif(choice==1 and accepted[1]==false): # Tara Glass
			accepted[1]=true
			app=load("res://employees/applications/special applications/towerglass.tres")
			return app
		elif(choice==2 and accepted[2]==false): #Lucia Bar
			accepted[2]=true
			app=load("res://employees/applications/special applications/lucia.tres")
			return app
		elif(choice==3 and accepted[3]==false):
			accepted[3]=true
			app=load("res://employees/applications/special applications/towercide.tres")
			return app
	#set gender and gendered name
	app.gender=randi_range(0,2)
	if(app.gender==0):
		first_name=app.FirstNameEnby.find_key(randi_range(0,app.FirstNameEnby.size()-1))
	elif(app.gender==1):
		first_name=app.FirstNameMasc.find_key(randi_range(0,app.FirstNameMasc.size()-1))
	elif(app.gender==2):
		first_name=app.FirstNameFem.find_key(randi_range(0,app.FirstNameFem.size()-1))
	last_name=app.LastName.find_key(randi_range(0,app.LastName.size()-1))
	app.name=first_name+" "+last_name
	# create two past jobs
	for i in 2:
		give_job=randi_range(0,99)
		if(give_job<30):
			app.past_jobs.append(Application.PastJobs.values().get(randi_range(0,8)))
		elif(give_job<40): 
			app.past_jobs.append(Application.PastJobs.values().get(randi_range(16,17)))
		else:
			app.past_jobs.append(Application.PastJobs.values().get(randi_range(9,15)))
	app.past_jobs.append(Application.PastJobs.values().pick_random())
	# check past jobs for whether they're good, add reliability score
	if (app.JOB_QUALITY.get(app.past_jobs[0])==1):
		app.reliability+=1
	elif (app.JOB_QUALITY.get(app.past_jobs[1])==1):
		app.reliability+=1
	else:
		pass # inefficiency condition
	# create 3 skills
	for i in 3:
		give_skills = randi_range(0,99)
		if(give_skills<5):
			app.skills.append(Application.Skills.values().get(randi_range(10,11)))
		elif(give_skills<27):
			app.skills.append(Application.Skills.values().get(randi_range(0,2)))
		elif(give_skills<53):
			app.skills.append(Application.Skills.values().get(randi_range(3,4)))
		elif(give_skills<79):
			app.skills.append(Application.Skills.values().get(randi_range(5,7)))
		else:
			app.skills.append(Application.Skills.values().get(randi_range(8,9)))
	# checks for evil skills (any evil skills instantly kills the skill section)
	if(app.SKILL_DIFFERENCE.get(app.skills[0])==-1):
		app.reliability-=1
		evil_modifier+=1
	elif(app.SKILL_DIFFERENCE.get(app.skills[1])==-1):
		app.reliability-=1
		evil_modifier+=1
	elif(app.SKILL_DIFFERENCE.get(app.skills[2])==-1):
		app.reliability-=1
		evil_modifier+=1
	else:
		#checks all skills are different
		if(app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[1]) and app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[2]) and app.SKILL_DIFFERENCE.get(app.skills[1])!=app.SKILL_DIFFERENCE.get(app.skills[2])):
			app.reliability+=1
		else:
			pass # inefficiency condition
	# create college, weighted ~30/55/15
	give_college=randi_range(0,99)
	if(give_college<30):
		app.college=app.College.values().get(randi_range(0,6))
	elif(give_college<85):
		app.college=app.College.values().get(randi_range(7,10))
	else:
		app.college=app.College.values().get(randi_range(11,12))
	# check whether college is good
	if(app.COLLEGE_QUALITY.get(app.college)==2):
		app.reliability+=1
	elif(app.COLLEGE_QUALITY.get(app.college)==1):
		pass #slacker
	elif(app.COLLEGE_QUALITY.get(app.college)==0):
		app.reliability-=1
		evil_modifier+=1
	else:
		pass #error
	# create why you wanted to attend, weighted ~30/55/15
	give_reason=randi_range(0,99)
	if(give_reason<30):
		app.company_reason=app.CompanyReason.values().get(randi_range(0,5))
	elif(give_reason<85):
		app.company_reason=app.CompanyReason.values().get(randi_range(6,8))
	else:
		app.company_reason=app.CompanyReason.values().get(randi_range(8,9))
	# check whether it's good
	if(app.REASON_QUALITY.get(app.company_reason)==2):
		app.reliability+=1
	elif(app.REASON_QUALITY.get(app.company_reason)==1):
		pass #slacker
	elif(app.REASON_QUALITY.get(app.company_reason)==0):
		app.reliability-=1
		evil_modifier+=1
	for i in 2:
		if(evil_modifier>0 and evil_modifier<4):
			app.reliability-=1
	print(app.reliability)
	return app
