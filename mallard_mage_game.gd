extends Control

@onready var play_button = $VBoxContainer/Play
@onready var test_button = $VBoxContainer/Test

func _ready() -> void:
	print("Play button is: ", play_button)
	play_button.pressed.connect(_on_play_pressed)
	test_button.pressed.connect(_on_test_pressed)

func _on_play_pressed() -> void:
	print("Clicked play")
	get_tree().change_scene_to_file("res://levels/Level1/level1_singleplayer.tscn")

func _on_test_pressed() -> void:
	print("Clicked test")
	get_tree().change_scene_to_file("res://levels/test_chamber/test_chamber.tscn")
