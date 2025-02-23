extends SelectMenu

func _process(_delta):
	#if !active:
		#return
		
	if pause_input :
		return
		
	var info = $TextWindowPanel/InsideMarginContainer/Info
	
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
	
	if Input.is_action_just_pressed("Cancel"):
		reset_and_hide()
