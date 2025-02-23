extends MenuElement
class_name PropertyDisplay

@export var starting_value = 0

var value : int
	
func _ready():
	super()
	set_value(value)
	
func set_value(v : int):
	value = v
	$Value.text = str(value)
