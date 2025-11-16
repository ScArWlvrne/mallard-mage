class_name CastingComponent
extends Node

@export var fireball_component: FireballComponent
@export var grapple_component: GrappleComponent
@export var time_stop_component: TimeStopComponent

@onready var mana_component := get_parent().get_node("ManaComponent")

enum Spell {
	NONE,
	FIREBALL,
	GRAPPLE,
	TIME_STOP
}

func cast_spell(spell: Spell, wants_to_cast: bool) -> void:	
	if not wants_to_cast:
		return
	
	print("Casting a spell...")
	match spell:
		Spell.FIREBALL:
			if mana_component._subtract_mana(10):
				fireball_component.cast()
			else:
				print("Not enough mana")
		Spell.GRAPPLE:
			print("Not Implemented")
			# grapple_component.cast()
		Spell.TIME_STOP:
			if mana_component._subtract_mana(1):
				time_stop_component.cast()
			else:
				print("Not enough mana")
	
	
