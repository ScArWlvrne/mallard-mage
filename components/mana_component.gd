class_name ManaComponent
extends Node

@export var max_mana: int = 100
var current_mana: int = max_mana

signal mana_changed(current: int, max: int)

func _subtract_mana(cost: int) -> bool:
	if current_mana >= cost:
		current_mana -= cost
		emit_signal("mana_changed", current_mana, max_mana)
		return true
	else:
		return false
		
func _add_mana(amount: int) -> void:
	current_mana = min(current_mana + amount, max_mana)
	emit_signal("mana_changed", current_mana, max_mana)
