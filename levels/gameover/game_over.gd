extends Control

@onready var button = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mallard_mage_game.tscn")
