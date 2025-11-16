class_name CastingComponent
extends Node

@export var fireball_component: FireballComponent
@export var grapple_component: GrappleComponent
@export var time_stop_component: TimeStopComponent


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
			fireball_component.cast()
		Spell.GRAPPLE:
			grapple_component.cast()
		Spell.TIME_STOP:
			time_stop_component.cast()
	
	
