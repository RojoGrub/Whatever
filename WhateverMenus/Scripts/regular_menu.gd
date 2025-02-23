extends MarginContainer
class_name RegularMenu

@export var starting_elements : Array[PackedScene]

var info

func _ready():
	info = $TextWindowPanel/InsideMarginContainer/Info
	for i in range(starting_elements.size()):
		var element = starting_elements[i].instantiate()
		info.add_child(element)

func get_elements() -> Array:
	return info.get_children()
	
func add_element(element : MenuElement):
	info.add_child(element)
