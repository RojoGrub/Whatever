extends Node
class_name Interactive

@export var its_name : String = "Object"
@export var look_message : String = "This thing is boring."
@export var interact_message : String = "Thing does nothing."
@export var attack_message : String = "Ouch! That hurt."

var other

func look():
	$CanvasLayer/StoryWindow.start_story_window(look_message.format({"o_name": its_name, "p_name": other.its_name}))
	
func interact():
	$CanvasLayer/StoryWindow.start_story_window(interact_message.format({"o_name": its_name, "p_name": other.its_name}))
	
func attack():
	$CanvasLayer/StoryWindow.start_story_window(attack_message.format({"o_name": its_name, "p_name": other.its_name}))


func _on_area_2d_body_entered(_body):
	pass # Replace with function body.


func _on_area_2d_body_exited(_body):
	pass # Replace with function body.
