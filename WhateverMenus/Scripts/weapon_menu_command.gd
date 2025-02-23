extends MenuCommand
class_name WeaponMenuCommand

@export var attack_string_good = "You attack the %s and deal %s damage."
#@export var attack_string_fair = "You hit the %s and deal %s damage."
@export var attack_string_miss = "You try to attack the %s but you swing and miss."
@export var damage : int = 0
@export var hit_chance : int = 50
@export var bp_cost : int = 10

func _ready():
	super()
	set_cost(str(bp_cost))
	
func set_label(some_string : String):
	$HSplitContainer/Label.text = some_string
	
func set_cost(some_string : String):
	$HSplitContainer/HBoxContainer/BattlePointCost.text = some_string
	
func _on_function():
	pass
	
