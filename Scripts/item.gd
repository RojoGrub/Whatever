extends Node
class_name Item

@export var item_name : String = "Item"
@export var description : String = "This is the ugliest item you have ever seen."

@export var item_command : PackedScene 
@export var weapon_command : PackedScene

@export var quantity : int = 1

func change_quantity(delta : int):
	quantity += delta
	if quantity < 0 :
		quantity = 0
