class_name InputComponent
extends Node

var input_horizontal: float = 0.0

enum Spell {
	NONE,
	FIREBALL,
	GRAPPLE,
	TIME_STOP
}

func _process(delta: float) -> void:
	input_horizontal = Input.get_axis("move_left", "move_right")
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
	
func get_cast_input() -> bool:
	return Input.is_action_just_pressed("cast")
	
func get_fireball_input() -> bool:
	return Input.is_action_just_pressed("select_fireball")
func get_grapple_input() -> bool:
	return Input.is_action_just_pressed("select_grapple")
func get_time_stop_input() -> bool:
	return Input.is_action_just_pressed("select_time_stop")
