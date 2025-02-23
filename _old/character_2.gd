extends Interactive
#class_name Character

enum Stat 
{
	LEVEL,
	EXP,
	EXP_NEXT,
	HP,
	HP_MAX,
	BP,
	BP_MAX,
	STRENGTH,
	DEXTERITY,
	CONSTITUTION,
	INTELLIGENCE,
	SPEED,
	LUCK,
	BP_PER_TURN,
	ATTACK_STR,
	STOMACH,
	STOMACH_MAX,
	HYDRATION,
	HYDRATION_MAX
}

func string_to_stat_enum(stat_string : String) -> Stat:
	match stat_string:
		"LEVEL":
			return Stat.LEVEL
		"EXP":
			return Stat.EXP
		"EXP_NEXT":
			return Stat.EXP_NEXT
		"HP":
			return Stat.HP
		"HP_MAX":
			return Stat.HP_MAX
		"BP":
			return Stat.BP
		"BP_MAX":
			return Stat.BP_MAX
		"STRENGTH":
			return Stat.STRENGTH
		"DEXTERITY":
			return Stat.DEXTERITY
		"CONSTITUTION":
			return Stat.CONSTITUTION
		"INTELLIGENCE":
			return Stat.INTELLIGENCE
		"SPEED":
			return Stat.SPEED
		"LUCK":
			return Stat.LUCK
		"BP_PER_TURN":
			return Stat.BP_PER_TURN
		"ATTACK_STR":
			return Stat.ATTACK_STR
		"STOMACH":
			return Stat.STOMACH
		"STOMACH_MAX":
			return Stat.STOMACH_MAX
		"HYDRATION":
			return Stat.HYDRATION
		"HYDRATION_MAX":
			return Stat.HYDRATION_MAX
		_:
			print("Stat not found.")
			return Stat.HP

@export var character_graphic : Texture2D
@export var speech : String = "Doo dee doo..."

@export var starting_stats : Dictionary = {
	"LEVEL": 1,
	"EXP": 0,
	"EXP_NEXT": 100,
	"HP": 100,
	"HP_MAX": 100,
	"BP": 50,
	"BP_MAX": 50,
	"STRENGTH": 10,
	"DEXTERITY": 10,
	"CONSTITUTION": 10,
	"INTELLIGENCE": 10,
	"SPEED": 10,
	"LUCK": 10,
	"BP_PER_TURN": 10,
	"ATTACK_STR": 10,
	"STOMACH": 10,
	"STOMACH_MAX": 10,
	"HYDRATION": 10,
	"HYDRATION_MAX": 10
}

var stat : Array[int]

signal take_turn

## Functions
#-----------------------------------------------

func _ready():
	pass
	stat.resize(Stat.size())
	stat.fill(0)
	var keys = starting_stats.keys()
	for i in range(keys.size()):
		stat[i] = string_to_stat_enum(keys[i])
	
func transfer_data(other : Character):
	stat = other.stat
	
var dead_dead = false

func _on_take_turn():
	var callable = Callable(self, "turn")
	SceneManager.get_node("Menus/EncounterWindow").actions.append([callable, []])
	
func turn():
	pass
