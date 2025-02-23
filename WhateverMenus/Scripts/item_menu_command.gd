extends MenuCommand
class_name ItemMenuCommand

@export var start_quantity : int = 10

var quantity : int = 10

var max_quantity : int = 10

func _ready():
	super()
	quantity = start_quantity
	max_quantity = start_quantity
	set_quantity(quantity)

func set_label(some_string : String):
	$HSplitContainer/HBoxContainer/Label.text = some_string
	
func set_quantity(number : int):
	quantity = number
	$HSplitContainer/Quantity.text = str(number)
	
func update_quantity(delta : int):
	quantity += delta
	$HSplitContainer/Quantity.text = str(quantity)
