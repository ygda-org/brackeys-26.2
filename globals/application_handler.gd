extends Node
var unique_skill_count : int
var evil_modifier : int
var firstname : String
var lastname : String
static var totalapps : int
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
		firstname=app.FirstNameEnby.find_key(randi_range(0,app.FirstNameEnby.size()-1))
	elif(app.gender==1):
		firstname=app.FirstNameMasc.find_key(randi_range(0,app.FirstNameMasc.size()-1))
	elif(app.gender==2):
		firstname=app.FirstNameFem.find_key(randi_range(0,app.FirstNameFem.size()-1))
	lastname=app.LastName.find_key(randi_range(0,app.LastName.size()-1))
	app.name=firstname+" "+lastname
	# create two past jobs
	app.past_jobs.append(Application.PastJobs.values().pick_random())
	app.past_jobs.append(Application.PastJobs.values().pick_random())
	# check past jobs for whether they're good, add reliability score
	if (app.JOB_QUALITY.get(app.past_jobs[0])==1):
		app.reliability+=1
	elif (app.JOB_QUALITY.get(app.past_jobs[1])==1):
		app.reliability+=1
	else:
		pass # inefficiency condition
	# create 3 skills
	app.skills.append(Application.Skills.values().pick_random())
	app.skills.append(Application.Skills.values().pick_random())
	app.skills.append(Application.Skills.values().pick_random())
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
		#checks to make sure skill 1, is different from skill 2, then if it is different from skill 3, confirming at least 2 different skills
		if(app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[1])):
			app.reliability+=1
		elif(app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[2])):
			app.reliability+=1
		else:
			pass # inefficiency condition
	# create college
	app.college=app.College.values().pick_random()
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
	# create why you wanted to attend
	app.company_reason=app.CompanyReason.values().pick_random()
	# check whether it's good
	if(app.REASON_QUALITY.get(app.company_reason)==2):
		app.reliability+=1
	elif(app.REASON_QUALITY.get(app.company_reason)==1):
		pass #slacker
	elif(app.REASON_QUALITY.get(app.company_reason)==0):
		app.reliability-=1
		evil_modifier+=1
	if(evil_modifier>0 and evil_modifier<4):
		app.reliability-=1
	
	return app
