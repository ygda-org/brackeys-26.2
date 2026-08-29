extends Resource
class_name Application
# Job quality of 0 means invalid job, job quality of 1 means valid job
const JOB_QUALITY = {
	PastJobs.COMPUTER_SCIENTIST : 1,
	PastJobs.GAME_DEVELOPER : 1, 
	PastJobs.DIGITAL_ARTIST : 1, 
	PastJobs.STORYBOARD_ARTIST : 1,
	PastJobs.QUALITY_ASSURER : 1,
	PastJobs.PLAYTESTER: 1,
	PastJobs.SOUNDTRACK_DESIGNER : 1,
	PastJobs.SFX_DESIGNER : 1,
	PastJobs.CODER : 1,
	PastJobs.MATHEMATICIAN : 0,
	PastJobs.YOUTUBER : 0,
	PastJobs.ACCOUNTANT : 0, 
	PastJobs.SECURITY_GUARD : 0,
	PastJobs.CASHIER : 0,
	PastJobs.SOCIALITE : 0,
	PastJobs.PENGUIN : 0,
	}
enum PastJobs {
	COMPUTER_SCIENTIST,
	GAME_DEVELOPER,
	DIGITAL_ARTIST,
	STORYBOARD_ARTIST,
	QUALITY_ASSURER,
	PLAYTESTER,
	SOUNDTRACK_DESIGNER,
	SFX_DESIGNER,
	CODER,
	#This is where invalid jobs start
	MATHEMATICIAN,
	YOUTUBER,
	ACCOUNTANT,
	SECURITY_GUARD,
	CASHIER,
	SOCIALITE,
	PENGUIN
}
# Skills with the same number are considered the same skill (Ex: 0 is programmer, coder, and programming expert. 
# Skills with a value of -1 indicate a saboteur.
const SKILL_DIFFERENCE = {
	Skills.PROGRAMMER : 0,
	Skills.CODER : 0,
	Skills.PROGRAMMING_EXPERT : 0,
	Skills.ARTIST : 1,
	Skills.DIGITAL_ARTIST : 1,
	Skills.MATHEMATICS_EXPERT : 2,
	Skills.MATH_WHIZ : 2,
	Skills.MATHEMATICIAN : 2,
	Skills.COMMUNICATOR : 3,
	Skills.TALKATIVE : 3,
	Skills.TOOL_REALLOCATER : -1,
	Skills.CRIME_DOER : -1
	}
enum Skills {
	# Can program
	PROGRAMMER,
	CODER,
	PROGRAMMING_EXPERT,
	# Can draw
	ARTIST,
	DIGITAL_ARTIST,
	# Can do math
	MATHEMATICS_EXPERT,
	MATH_WHIZ,
	MATHEMATICIAN,
	# Can talk to people
	COMMUNICATOR,
	TALKATIVE,
	# EVIL
	TOOL_REALLOCATER,
	CRIME_DOER
}
# 2 is high-quality (normal), 1 is low-quality (inefficient), 0 is degree mill (saboteur)
const COLLEGE_QUALITY= {
	College.PRESTIGE_U : 2,
	College.JAMES_BAKER_U : 2,
	College.CITADEL_U : 2,
	College.KNOWLEDGE_U : 2,
	College.SERPENT_U : 2,
	College.HELIOS_TECH : 2,
	College.SPIRIT_COLLEGE : 2,
	College.COLLEGE_U : 1,
	College.COMMUNITY_COLLEGE : 1,
	College.HEART_COLLEGE : 1,
	College.MOUNTAIN_TECH : 1,
	College.COMMUNITY_U : 0,
	College.JOHN_COLLEGE : 0
}
enum College
{
	#High-quality universities
	PRESTIGE_U,
	JAMES_BAKER_U,
	CITADEL_U,
	KNOWLEDGE_U,
	SERPENT_U,
	HELIOS_TECH,
	SPIRIT_COLLEGE,
	#Low-quality universities
	COLLEGE_U,
	COMMUNITY_COLLEGE,
	HEART_COLLEGE,
	MOUNTAIN_TECH,
	#Degree Mill
	COMMUNITY_U,
	JOHN_COLLEGE,
}
# Good reasons follow the company motto or the company mission statement.
# Company motto: Trust Not, Fear Not, Fail Not
# Company mission statement: Encourage orderly game-design and a disciplined workplace.
# 2 follows either one, 1 follows neither but isn't harmful, 0 shows disloyalty
const REASON_QUALITY = {
	CompanyReason.DISTRUSTFUL : 2,
	CompanyReason.FEARLESS : 2,
	CompanyReason.ORGANIZED : 2,
	CompanyReason.GAME_DESIGNER : 2,
	CompanyReason.DISCIPLINED : 2,
	CompanyReason.FLAWLESS : 2,
	CompanyReason.TALENTED : 1,
	CompanyReason.MOTIVATED : 1,
	CompanyReason.TRUSTING : 1,
	CompanyReason.ASKED_TO : 0,
	CompanyReason.UNTRUSTWORTHY : 0
}
enum CompanyReason
{
	#Good reasons
	DISTRUSTFUL,
	FEARLESS,
	ORGANIZED,
	GAME_DESIGNER,
	DISCIPLINED,
	FLAWLESS,
	#Bad reasons
	TALENTED,
	MOTIVATED,
	TRUSTING,
	#Disloyal reasons
	ASKED_TO,
	UNTRUSTWORTHY
}
enum FirstNameMasc
{
	BOB,
	JOHN,
	JON,
	RITHICK,
	ARTHUR,
	JIM,
	PETER,
	ELI,
}
enum FirstNameFem
{
	SARAH,
	LILA,
	LEAH,
	ABIGAIL,
	HELEN,
	ANNA,
	SUSIE,
	HANSIKA,
}
enum FirstNameEnby
{
	ALEX,
	SAM,
	SALEM,
	THEO,
	LETHE,
	JESSE,
	SAWYER,
	OPAL,
	GEORGI
}
enum LastName
{
	SMITH,
	JONES,
	TAYLOR,
	NGUYEN,
	BAKER,
	PARKER,
	NYX,
	DOE,
	WARD
}
@export var name: String
@export var past_jobs: Array[PastJobs]
@export var skills: Array[Skills]
@export var college: College
@export var company_reason: CompanyReason
@export var reliability: int
@export var gender: int #0 is enby, 1 is male, 2 is female
