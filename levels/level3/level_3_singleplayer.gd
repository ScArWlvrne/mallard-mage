extends Node

func _ready():
	var mana_component = $Level3/Player/ManaComponent
	var mana_bar = $UILayer/ManaBar

	# Connect the signal
	mana_component.connect("mana_changed", Callable(self, "_on_mana_changed"))

	# Update the bar immediately
	mana_bar.max_value = mana_component.max_mana
	mana_bar.value = mana_component.current_mana


func _on_mana_changed(current: int, max: int) -> void:
	$UILayer/ManaBar.max_value = max
	$UILayer/ManaBar.value = current
