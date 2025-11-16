class_name FireballComponent
extends Node

var fireball_scene: PackedScene = preload("res://spells/fireball.tscn")



# Called when the node enters the scene tree for the first time.
func cast() -> void:
	print("I cast fireball!")
	var player = get_parent().get_parent()
	var fireball = fireball_scene.instantiate()
	get_tree().current_scene.add_child(fireball)
	var position = player.global_position # TODO: replace with arrow position when reimplemented
	var angle = 0 # TODO: replace with arrow angle later
	
	fireball.shoot(position, angle)
