extends Node2D

@export var first_scene : PackedScene

func _process(_delta):
	if Input.is_action_just_pressed("Accept"):
		get_tree().change_scene_to_packed(first_scene)
	if Input.is_action_just_pressed("Cancel"):
		get_tree().quit()
