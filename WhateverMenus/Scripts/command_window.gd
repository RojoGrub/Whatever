extends RegularMenu
class_name SelectMenu

var active = false
var pause_input = false
var select_index = 0
var select_number = 0

var current_process_mode
var menu_complete = false

func _ready():
	if starting_elements.size() < 1 :
		return		
	set_menu_commands()
	initialize_menu()	

func _process(_delta):
	#if !active:
		#return
	if pause_input :
		return
	
	if info.get_child_count() < 1:
		return
	
	if Input.is_action_just_pressed("MoveDown"):
		info.get_child(select_index).get_child(0).toggle()
		select_index += 1
		if select_index >= select_number:
			select_index = 0
		info.get_child(select_index).get_child(0).toggle()
	
	if Input.is_action_just_pressed("MoveUp"):
		info.get_child(select_index).get_child(0).toggle()
		select_index -= 1
		if select_index < 0:
			select_index = select_number - 1
		info.get_child(select_index).get_child(0).toggle()
		
func set_menu_commands():
	if menu_complete:
		return
	for i in range(starting_elements.size()) :
		var command = starting_elements[i].instantiate()
		info.add_child(command)
		#print(owner)
		#if owner is OverworldMenu:
			#command.call_menu = true
	menu_complete = true
	
func add_menu_commands(cmmds:Array[PackedScene]) -> String:
	var list = ""
	for i in range(cmmds.size()) :
		var command = cmmds[i].instantiate()
		
		list += command.label + " "
		info.add_child(command)
	initialize_menu()
	return list
	
func add_menu_command(cmmd:PackedScene) -> String:
	var list = ""
	var command = cmmd.instantiate()
	list += command.label + " "
	info.add_child(command)
	initialize_menu()
	return list
	
func initialize_menu() :
	select_number = info.get_child_count()
	for i in range(select_number):
		if info.get_child(i).get_child(0).active:
			info.get_child(i).get_child(0).toggle()
			
	info.get_child(0).get_child(0).toggle()
		
func reset_and_hide():
	visible = false
	#active = false
	select_index = 0
	if info.get_child_count() > 0:
		for i in range(info.get_child_count()):
			info.get_child(i).deactivate()
		info.get_child(0).activate()
	process_mode = Node.PROCESS_MODE_DISABLED
	
func reset():
	select_index = 0
	if info.get_child_count() < 1:
		return
	for i in range(info.get_child_count()):
		info.get_child(i).deactivate()
	info.get_child(0).activate()
	
func disable_and_hide():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	
func activate_and_show() :
	reset()
	visible = true
	enable_and_pause_input()
	
func enable_and_pause_input():
	pause_input = true
	for i in range(info.get_child_count()):
		info.get_child(i).set_input_delay()
	$InputTimer.start()
	process_mode = Node.PROCESS_MODE_INHERIT
	
func save_and_pause():
	print(self, process_mode , Node.PROCESS_MODE_DISABLED, Node.PROCESS_MODE_INHERIT)
	current_process_mode = process_mode
	process_mode = Node.PROCESS_MODE_DISABLED
	
func load_and_resume():
	process_mode = current_process_mode
	if process_mode == Node.PROCESS_MODE_INHERIT:
		enable_and_pause_input()

func _on_input_timer_timeout():
	$InputTimer.stop()
	pause_input = false
