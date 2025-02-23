extends Node2D

@export var player : PackedScene

func player_instantiate():
	var new_player = player.instantiate()
	new_player.position = global_position
	return new_player
