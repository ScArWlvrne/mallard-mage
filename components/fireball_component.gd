class_name FireballComponent
extends Node

var fireball_scene: PackedScene = preload("res://spells/fireball.tscn")



# Called when the node enters the scene tree for the first time.
func cast() -> void:
	print("I cast fireball!")
	var player = get_parent().get_parent()
	var arrow = player.get_node("AimingArrowComponent")
	var fireball = fireball_scene.instantiate()
	get_tree().current_scene.add_child(fireball)
	var position = arrow.global_position 
	var angle = arrow.global_rotation
	
	fireball.shoot(position, angle)
