extends Area2D

@export var mana_amount: int = 20

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.has_node("ManaComponent"):
		var mana_component = body.get_node("ManaComponent")
		mana_component._add_mana(mana_amount)
		queue_free()  # Remove the potion from the scene
