extends CharacterBody2D
class_name Player

@export var walk_speed = 100
@export var max_bullets : int = 6

var other : NPC = null
var ignore_pause = false

var character_sheet : Character
var inventory : Inventory

func _ready():
	pass
	
func _physics_process(_delta):
	var directionX = Input.get_axis("MoveLeft", "MoveRight")
	var directionY = Input.get_axis("MoveUp", "MoveDown")
	
	velocity = Vector2(directionX, directionY) * walk_speed
		
	if velocity.length() > 0:
		$AnimationTree.set("parameters/Walk/blend_position", Vector2(directionX, directionY))
		
	move_and_slide()
	
func change_position(new_position):
	set_deferred("position", new_position)
	
func _on_area_2d_area_entered(area):
	if  area.get_parent() is Interactive:
		other = area.get_parent()
		#print(other)

func _on_area_2d_area_exited(area):
	if  area.get_parent() is Interactive && !ignore_pause:
		other = null
		#print(other)
		
func get_other():
	return other
	
#func get_character_sheet():
	#return character_sheet
	#
#func get_inventory():
	#return inventory
	
#func transfer_data(other_player : Player):
	#$PlayerCharacter.transfer_data(other_player.get_character_sheet())
	##$Inventory.transfer_data(other_player.get_inventory())
