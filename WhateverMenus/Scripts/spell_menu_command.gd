extends MenuCommand

@export var blood_cost : int = 10
@export var unit_label : String = "BP"

func _ready():
	super()
	update_blood_cost(blood_cost)
	update_unit_label(unit_label)
	
func update_blood_cost(number : int):
	$BloodCost.text = str(number)
	
func update_unit_label(some_string : String):
	$Unit.text = some_string
