extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var event : InputEvent = shortcut.events[0]
	text = event.as_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
