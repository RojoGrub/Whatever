extends RegularMenu
class_name StatusWindow

@export var s_name : String = "Dude"
@export var status_elements : Dictionary
#@export var status_order : Array[String]

func _ready():
	create_name(s_name)
	create_properties(status_elements)
		
func set_name_label(n : String):
	s_name = n
	info.set_label(n)

func create_properties(status_d : Dictionary):
	if status_d.keys().size() < 1:
		return
		
	for i in range(status_d.keys().size()):
		var element = starting_elements[0].instantiate()
		element.set_label(status_d.keys()[i] + ": ")
		element.set_value(status_d[status_d.keys()[i]][0])
		add_element(element)
		
	#organize the properties
	var elements = get_elements()
	for i in range(1, status_d.keys().size() + 1):
		print(i, " ", info.get_child_count())
		var element = elements[i]
		print(element, status_d[status_d.keys()[i - 1]][1])
		info.move_child(element, status_d[status_d.keys()[i - 1]][1])

func create_name(s : String):
	var stat_name = starting_elements[1].instantiate()
	stat_name.set_label(s)
	add_element(stat_name)
