extends Inventory
class_name ItemCylinder

var can_open = false
var empty = false

func _process(_delta):
	if Input.is_action_just_pressed("Accept") && can_open && !empty:
		interact()
	
func interact():
	super()
	empty = true

func look():
	look_message = "This is your own personal Item Cylinder. It holds your stuff."
	super()

func _on_story_window_totally_finished():
	pass

func _on_body_entered(body):
	if body is Player:
		can_open = true
		other = body

func _on_body_exited(body):
	if body is Player:
		can_open = false
		other = null
