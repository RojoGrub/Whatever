extends Area2D
class_name SceneChangeTrigger

@export var next_scene = 1
@export var trigger_id = 56
@export var relative_position = Vector2(0, 200)
@export var collider_dimensions = Vector2(100, 100)
@export var disabled = true

@onready var enter_position = position

signal player_entered_trigger(player : Player, next_scene_index : int, trigger_id : int)

func _ready():
	$CollisionShape2D.shape.size = collider_dimensions
	$CollisionShape2D.set_deferred("disabled", disabled)
	enter_position += relative_position

func _on_body_entered(body):
	if get_parent() is Location && body is Player:
		#$CollisionShape2D.disabled = true
		#get_parent().send_location_change_signal(next_scene, trigger_id)
		player_entered_trigger.emit(body, next_scene, trigger_id)

func _on_body_exited(body):
	if get_parent() is Location && body is Player:
		$CollisionShape2D.set_deferred("disabled", false)
