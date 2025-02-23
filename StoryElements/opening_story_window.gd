extends StoryWindow

@export var next_scene : PackedScene

var opening_story : String = \
\
"In the mid 21st century, the world experienced a population collapse. The richest man in the world, Jeffery Sneebles, \
decided to save the world... by cloning himself over and over again. This was the beginning of the new \
age. An age in which the human race is manufactured rather than born. Now, in the year 156SD, the world is \
completely populated by Jeffery's clones. You are a clone, manufactured 32 years ago."

func _ready():
	SceneManager.visible = false
	start_story_window(opening_story)


func _on_opening_totally_finished():
	get_tree().change_scene_to_packed(next_scene)
