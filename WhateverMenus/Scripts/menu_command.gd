extends HBoxContainer
class_name MenuCommand

@export var label = "Command" 
@export var message : String = "You do something."
@export var calls_menu = false
@export var calls_action = false

@export var player : Player
@export var other : Interactive
@export var location: Location
@export var story_window : StoryWindow

var pause_input = false
var connection : String = "_on_command"

signal command(player : Player, other : Interactive, location : Location)

signal command_call_action()
signal queue_command(callable : Callable, arguements : Array)

func _ready():
	start_input_timer()
	set_label(label)
		
func _process(_delta):
	if pause_input:
		return
		
	if Input.is_action_just_pressed("Accept"):
		if calls_action:
			command_call_action.emit(player, other, location)
			disable_parent()
			return
		command.emit(player, other, location)
		if(calls_menu):
			return
		disable_parent()
		
func set_label(some_string : String):
	$Label.text = some_string
	
func deactivate():
	$Cursor.deactivate()
	
func activate():
	$Cursor.activate()
	
func disable_parent():
	get_parent().owner.disable_and_hide()

func _on_command(p : Player = player, o : Interactive = other, l : Location = location):
	message.format({"p_name": p.get_node("Character").character_name,
					"o_name": o.o_name,
					"l_name": l.location_name})
	story_window.setup_story_window_with_message(message)
	
func _on_command_call_action(p : Player = player, o : Interactive = other, l : Location = location) :
	var callable = Callable(self, connection)
	var arguments = [p, o, l]
	queue_command.emit(callable, arguments)

func _on_input_timer_timeout():
	$InputTimer.stop()
	pause_input = false
	
func start_input_timer():
	pause_input = true
	$InputTimer.start()

#func _on_command(player : Player, other : Interactive, location : Location) :
	#pass
#func _on_command_call_action(player : Player, other : Interactive, location) :
	#pass
