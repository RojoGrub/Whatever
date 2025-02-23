extends Node2D
class_name Location

@export var location_name = "The Lair"

var current_player : Player
var last_player : Player

signal changing_location(player : Player, index : int, enter_trigger_id : int)

func _ready():
	if changing_location.get_connections().size() == 0:
		changing_location.connect(SceneManager._on_change_location)
	current_player = $Player
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is SceneChangeTrigger:
			child.player_entered_trigger.connect(send_location_change_signal)
	SceneManager.current_location = self
	
func send_location_change_signal(player : Player, location_index : int, enter_trigger_id : int):
	changing_location.emit(player, location_index, enter_trigger_id)
	
func move_player_to_enter_trigger(trigger_id : int, l_player : Player):
	$Player.transfer_data(l_player)
	
	var child = null
	for i in range(get_child_count()):
		child = get_child(i)
		if child is SceneChangeTrigger && child.trigger_id == trigger_id:
			$Player.call_deferred("change_position", child.relative_position + child.position)
			
func disable_location_process():
	get_node("Player").ignore_pause = true
	process_mode = Node.PROCESS_MODE_DISABLED
	
func enable_location_process():
	get_node("Player").ignore_pause = false
	process_mode = Node.PROCESS_MODE_INHERIT
	
func set_shortcuts():
	#SceneManager.current_location = self
	current_player = $Player
