extends Control
class_name PlayerMenus

var active = true

func _ready():
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("Cancel"):
		$CommandWindow.enable_and_pause_input()
	
func disable_menu():
	active = false
	visible = false
	$StoryWindow.disable_window()
	$ItemMenu.reset_and_hide()
	#$WeaponMenu.reset_and_hide()
	$CommandWindow.reset_and_hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
	
func enable_menu():
	active = true
	visible = true
	$CommandWindow.activate_and_show()
	process_mode = Node.PROCESS_MODE_INHERIT

func _on_story_window_totally_finished():
	disable_menu()
	SceneManager.enable_location()

func setup_story_window_with_message(message : String):
	$ItemMenu.process_mode = Node.PROCESS_MODE_DISABLED
	$CommandWindow.process_mode = Node.PROCESS_MODE_DISABLED
	$StoryWindow.start_story_window(message)
