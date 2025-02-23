extends HBoxContainer
class_name MenuElement

@export var label : String = "Element"

func _ready():
	set_label(label)
	
func set_label(l : String):
	label = l
	$Label.text = label
