extends TextureRect

@export var cursor_graphic : Texture
@export var cursor_blank : Texture

var active = false

func _ready():
	texture = cursor_blank

func toggle():
	active = !active
	if active:
		texture = cursor_graphic
	else:
		texture = cursor_blank
		
func activate():
	active = true
	texture = cursor_graphic
	
func deactivate():
	active = false
	texture = cursor_blank


func _on_input_timer_timeout():
	pass # Replace with function body.
