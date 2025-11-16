extends Area2D

@export var next_scene_path: String

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":  # or use groups/tags
		get_tree().change_scene_to_file(next_scene_path)
