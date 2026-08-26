extends Node

var unique_skill_count : int
func create_application():
	var app=Application.new()
	# create two past jobs
	app.past_jobs.append(Application.PastJobs.MATHEMATICIAN)
	# check past jobs for whether they're good, add reliability score
	if (app.JOB_QUALITY.get(app.past_jobs[0])==1):
		app.reliability+=1
	elif (app.JOB_QUALITY.get(app.past_jobs[1])==1):
		app.reliability+=1
	else:
		pass # inefficiency condition
	# create 3 skills
	# checks for evil skills (any evil skills instantly kills the skill section)
	if(app.SKILL_DIFFERENCE.get(app.skills[0])==-1):
		app.reliability-=1
	elif(app.SKILL_DIFFERENCE.get(app.skills[1])==-1):
		app.reliability-=1
	elif(app.SKILL_DIFFERENCE.get(app.skills[2])==-1):
		app.reliability-=1
	else:
		#checks to make sure skill 1, is different from skill 2, then if it is different from skill 3, confirming at least 2 different skills
		if(app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[1])):
			app.reliability+=1
		elif(app.SKILL_DIFFERENCE.get(app.skills[0])!=app.SKILL_DIFFERENCE.get(app.skills[2])):
			app.reliability+=1
		else:
			pass # inefficiency condition
	# create college
	# check whether college is good
	if(app.COLLEGE_QUALITY.get(app.college)==2):
		app.reliability+=1
	elif(app.COLLEGE_QUALITY.get(app.college)==1):
		pass #slacker
	elif(app.COLLEGE_QUALITY.get(app.college)==0):
		app.reliability-=1
	else:
		pass #error
	# create why you wanted to attend
	# check whether it's good
	if(app.REASON_QUALITY.get(app.company_reason)==2):
		app.reliability+=1
	elif(app.REASON_QUALITY.get(app.company_reason)==1):
		pass #slacker
	elif(app.REASON_QUALITY.get(app.company_reason)==0):
		app.reliability-=1
	pass
