extends Node2D

@export var locations: Array[PackedScene]

var current_location : Location = null

func _ready():
	$Menus/PlayerMenus.disable_menu()
	$Menus/EncounterMenus.disable_menu()
	
#func _input(event):
	#if event.is_pressed():
		#var button_index = event.button_index
		#print(button_index)
	
func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		var ow_active = $Menus/PlayerMenus.active
		var en_active = $Menus/EncounterMenus.active
		if ow_active:
			$Menus/PlayerMenus.disable_menu()
			enable_location()
		if !ow_active && !en_active:
			$Menus/PlayerMenus.enable_menu()
			disable_location()
			
func disable_location():
	var location = get_tree().root.get_child(1)
	#location.visible = false
	location.disable_location_process()
	
func enable_location():
	var location = get_tree().root.get_child(1)
	#location.visible = true
	location.enable_location_process()

func _on_change_location(player : Player, index : int, trigger_id : int):
	var new_scene = locations[index].instantiate()
	get_tree().root.call_deferred("add_child", new_scene)
	var c_location = get_tree().root.get_child(1)
	
	new_scene.move_player_to_enter_trigger(trigger_id, player)
	c_location.queue_free()
	
	new_scene.changing_location.connect(_on_change_location)
	
	current_location = new_scene

func activate_encounter_window(monster_index : int):
	disable_location()
	$Menus/OverWorldMenu.disable_menu()
	$Menus/EncounterMenus.enemy_index = monster_index
	$EncounterTimer.start()
	
func activate_location_after_battle():
	$Menus/EncounterMenus.disable_menu()
	enable_location()
	
func set_menus(_pc : Character, _pi : Inventory):
	pass
	#$Menus/EncounterMenus.setup_player_character(pc, pi)
	#$Menus/EncounterMenus.player_character = pc
	#$Menus/OverWorldMenu.setup_player_character(pc, pi)
	#
	#$Menus/OverWorldMenu.disable_menu()
	#$Menus/EncounterMenus.disable_menu()
	
func disable_menus():
	$Menus/OverWorldMenu.disable_menu()
	$Menus/EncounterMenus.disable_menu()
	
func _on_encounter_timer_timeout():
	$EncounterTimer.stop()
	$Menus/EncounterMenus.enable_menu()
