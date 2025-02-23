extends Control
class_name StoryWindow

@export var the_message = ""
@export var pip_character = "v"
@export var tween_char_per_second : float = 42

#@onready var portrait = $TextWindow/TextWindowMarginContainer/TextWidowPanel/InsideMarginContainer/HBoxContainer/Portrait
@onready var message = $TextWindowMarginContainer/TextWindowPanel/InsideMarginContainer/HBoxContainer/Message
@onready var pip = $TextWindowMarginContainer/TextWindowPanel/InsideMarginContainer/HBoxContainer/Pip

var tween : Tween
var text_queue = []
var message_index = 0
#var pause_input = false

signal totally_finished

enum State
{
	START,
	READY,
	READING,
	PART_FINISHED,
	TOTALLY_FINISHED
}

var busy = false
var current_state = State.START

func _ready():
	current_state = State.START
	pip.text = ""
	process_mode = Node.PROCESS_MODE_DISABLED
	#text_queue = split_message_into_parts(the_message)
		
func _process(_delta):
	#if current_state == State.TOTALLY_FINISHED:
		#return
		
	match current_state:
		State.START:
			text_queue = split_message_into_parts(the_message)
			change_state(State.READY)
		State.READY:
			if text_queue.is_empty():
				return
			
			display_text(text_queue[message_index])
		State.READING:
			#if pause_input:
				#return
			if Input.is_action_just_pressed("Accept") || Input.is_action_just_pressed("Cancel"):
				message.visible_ratio = 1
				tween.stop()
				pip.text = pip_character
				change_state(State.PART_FINISHED)
		State.PART_FINISHED:
			#if pause_input:
				#return
			if Input.is_action_just_pressed("Accept") || Input.is_action_just_pressed("Cancel"):
				change_state(State.READY)
		State.TOTALLY_FINISHED:
			#if pause_input:
				#return
			if Input.is_action_just_pressed("Accept") || Input.is_action_just_pressed("Cancel"):
				totally_finished.emit()
		
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pip.text = ""
			message.text = ""
			message.visible_ratio = 0
			
		State.READING:
			pass
		State.PART_FINISHED:
			message_index += 1
			if message_index >= text_queue.size():
				
				change_state(State.TOTALLY_FINISHED)
		State.TOTALLY_FINISHED:
			message_index = 0

func start_story_window(mssg : String):
	reset()
	the_message  = mssg
	
	show_window()
	process_mode = Node.PROCESS_MODE_INHERIT
	busy = true
	
func disable_window():
	reset()
	hide_window()

func hide_window():
	visible = false

func show_window():
	visible = true
	
func reset():
	process_mode = Node.PROCESS_MODE_DISABLED
	change_state(State.START)
	the_message = ""
	message.text = ""
	pip.text = ""
	
func split_message_into_parts(message_to_split):
	var parts = []
	var start_index = 0
	while start_index < message_to_split.length():
		var end_index = start_index + 1
		
		message.text = message_to_split.substr(start_index, end_index - start_index)
		
		var message_lines = message.get_line_count()
		var message_visible_lines = message.get_visible_line_count()
		
		while end_index < message_to_split.length() && message_lines <= message_visible_lines :
			end_index += 1
			message.text = message_to_split.substr(start_index, end_index - start_index)
			message_lines = message.get_line_count()
			message_visible_lines = message.get_visible_line_count()
			
		var message_part = message_to_split.substr(start_index, end_index - start_index)
		while(message_part[message_part.length() - 1] != ' ' && end_index < message_to_split.length() && message_to_split.substr(start_index, end_index + 1 - start_index) != ' '):
			end_index -= 1
			message_part = message_to_split.substr(start_index, end_index - start_index)
		
		parts.append(message_to_split.substr(start_index, end_index - start_index))
		start_index = end_index
	return parts
	
func display_text(next_message):
	if not next_message is String:
		return
	
	change_state(State.READING)
	message.text = next_message
	message.visible_characters = 0
		
	show_window()
	
	
	tween = create_tween()
	tween.tween_property(message, "visible_ratio", 1, message.text.length() / tween_char_per_second)
	tween.finished.connect(_on_tween_finished)
	#await tween.PART_FINISHED
	
func _on_tween_finished():
	pip.text = pip_character
	change_state(State.PART_FINISHED)

func _on_input_timer_timeout():
	$InputTimer.stop()
	#pause_input = false # Replace with function body.


func _on_totally_finished():
	hide_window()
	busy = false
	reset()
