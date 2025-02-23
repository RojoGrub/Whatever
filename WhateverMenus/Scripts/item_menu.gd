extends SelectMenu

#var player_inventory : Inventory

func _ready():
	pass
	
func _process(_delta):
	super(_delta)
	if Input.is_action_just_pressed("Cancel"):
		reset_and_hide()

#func setup(player_inventory : Inventory):
	#if player_inventory.items.size() < 1:
		#return
		#
	#set_item_menu_commands(player_inventory)
		#
	#var info = $TextWindowPanel/InsideMarginContainer/Info
	#select_number = info.get_child_count()
	#for i in range(select_number):
		#if info.get_child(i).get_child(0).active:
			#info.get_child(i).get_child(0).toggle()
			#
	#info.get_child(0).get_child(0).toggle()
	#
#func set_item_menu_commands(player_inventory : Inventory):
	#if menu_complete:
		#return
		#
	#for i in range(player_inventory.items.size()):
		#var item = player_inventory.items[i].instantiate()
		#$TextWindowPanel/InsideMarginContainer/Info.add_child(item)
	#menu_complete = true
