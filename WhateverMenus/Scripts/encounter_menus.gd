extends PlayerMenus
class_name EncounterMenus

@export var enemy_library : Array[PackedScene]
@export var enemy_index : int = 0

var current_npc : NPC = null
var current_enemy : Character = null
var player_character : Character = null
var actions : Array = []
var signals_set = false

func _process(_delta):
	super(_delta)
	#if Input.is_action_just_pressed("Cancel"):
		#$ItemMenu.reset_and_hide()
		#$WeaponMenu.reset_and_hide()
		#$CommandWindow.enable_and_pause_input()
	
func disable_menu():
	active = false
	visible = false
	$StoryWindow.disable_window()
	$ItemMenu.reset_and_hide()
	$WeaponMenu.reset_and_hide()
	$CommandWindow.reset_and_hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
func enable_menu():
	active = true
	visible = true
	#$CommandWindow.activate_and_show()
	process_mode = Node.PROCESS_MODE_INHERIT
	set_enemy()

func set_enemy():
	current_enemy = enemy_library[enemy_index].instantiate()
	add_child(current_enemy)
	$EnemyWindow/MarginContainer/Enemy.texture = current_enemy.character_graphic
	current_enemy.take_turn.connect(_on_take_turn)
	setup_story_window_with_message("A " + current_enemy.character_name + " draws near.")
	
#func setup_player_character(pc : Character, pi : Inventory):
	#super(pc, pi)
	
	if signals_set:
		return
	connect_signals()
	
	signals_set = true
	
func connect_signals():
	for i in range($CommandWindow/TextWindowPanel/InsideMarginContainer/Info.get_child_count()):
		var item = $CommandWindow/TextWindowPanel/InsideMarginContainer/Info.get_child(i)
		if !item.is_connected("command_call_action", _on_command_call_action):
			item.function_encounter.connect(_on_command_call_action)
	for i in range($ItemMenu/TextWindowPanel/InsideMarginContainer/Info.get_child_count()):
		var item = $ItemMenu/TextWindowPanel/InsideMarginContainer/Info.get_child(i)
		if !item.is_connected("command_call_action", _on_command_call_action):#item.function_encounter.disconnect(_on_function_encounter)
			item.function_encounter.connect(_on_command_call_action)
	for i in range($WeaponMenu/TextWindowPanel/InsideMarginContainer/Info.get_child_count()):
		var item = $WeaponMenu/TextWindowPanel/InsideMarginContainer/Info.get_child(i)
		if !item.is_connected("command_call_action", _on_command_call_action):
			item.function_encounter.connect(_on_command_call_action)
	
func _on_command_call_action():
	current_enemy.take_turn.emit()
	
func _on_take_turn():
	proceed_with_battle(0)
	
func proceed_with_battle(index : int):
	actions[index][0].callv(actions[index][1])
	actions.pop_front()
	
func _on_turn_timer_timeout():
	pass # Replace with function body.

func kill_enemy():
	$EnemyWindow/MarginContainer/Enemy.texture = null
	current_enemy.dead_dead = true
	if current_npc != null:
		current_npc.queue_free()
		current_npc = null
	actions = []
	setup_story_window_with_message("You have dispatched the " + current_enemy.character_name + ".")
	
func _on_story_window_totally_finished():
	$CommandWindow.activate_and_show()
	if current_enemy.dead_dead:
		SceneManager.activate_location_after_battle()
		return
	if current_enemy.health_points <= 0:
		kill_enemy()
		return
	if actions.size() > 0:
		proceed_with_battle(0)

func setup_story_window_with_message(message : String):
	$ItemMenu.process_mode = Node.PROCESS_MODE_DISABLED
	$CommandWindow.process_mode = Node.PROCESS_MODE_DISABLED
	$WeaponMenu.process_mode = Node.PROCESS_MODE_DISABLED
	$StoryWindow.start_story_window(message)
