extends Character

#func add_battle_points(value : int):
	#super(value)
	#get_tree().root.get_node("SceneManager/Menus/EncounterMenus").update_bp.emit(battle_points)
	#get_tree().root.get_node("SceneManager/Menus/OverWorldMenu").update_bp.emit(battle_points)
		#
#func get_hit(value : int):
	#super(value)
	#get_tree().root.get_node("SceneManager/Menus/EncounterMenus").update_hp.emit(health_points)
	#get_tree().root.get_node("SceneManager/Menus/OverWorldMenu").update_hp.emit(health_points)
