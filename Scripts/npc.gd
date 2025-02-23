extends CharacterBody2D
class_name NPC

@export var speech = "Hello Captain!"
@export var enemy_index : int = 0 

var can_talk = false

func _process(_delta):
	if Input.is_action_just_pressed("Accept") && can_talk:
		talk()
	#move_and_slide()
	
func talk():
	if $CanvasLayer/StoryWindow.busy:
		return
	$CanvasLayer/StoryWindow.start_story_window(speech)

func _on_story_window_totally_finished():
	pass

func _on_body_entered(body):
	if body is Player:
		can_talk = true

func _on_body_exited(body):
	if body is Player:
		can_talk = false
