class_name FireballComponent
extends Node

var fireball_scene: PackedScene = preload("res://spells/fireball.tscn")



# Called when the node enters the scene tree for the first time.
func cast() -> void:
	print("I cast fireball!")
	var player = get_parent().get_parent()
	var arrow = player.get_node("AimingArrowComponent")
	var fireball = fireball_scene.instantiate()
	# Connect the time stop signal
	var time_stop = get_parent().get_node("TimeStop")
	time_stop.connect("time_stop_triggered", Callable(fireball, "_on_time_stop_triggered"))
	get_tree().current_scene.add_child(fireball)
	var arrow_visual = arrow.get_node("ArrowSprite")  # or whatever name you used
	var position = arrow_visual.global_position
	var angle = arrow_visual.global_rotation
	
	fireball.shoot(position, angle)
	fireball._on_time_stop_triggered(time_stop.is_time_stopped)
