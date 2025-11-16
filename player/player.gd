extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var casting_component: CastingComponent
@export var aiming_arrow_component: AimingArrowComponent
@export var mana_component: ManaComponent

enum Spell {
	NONE,
	FIREBALL,
	GRAPPLE,
	TIME_STOP
}

var current_spell = Spell.FIREBALL

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
		aiming_arrow_component.set_facing_direction(sign(velocity.x))
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if input_component.get_fireball_input():
		aiming_arrow_component.show()
		current_spell = Spell.FIREBALL
		print(current_spell)
	if input_component.get_grapple_input():
		aiming_arrow_component.show()
		current_spell = Spell.GRAPPLE
		print(current_spell)
	if input_component.get_time_stop_input():
		aiming_arrow_component.hide()
		current_spell = Spell.TIME_STOP
		print(current_spell)
		
	casting_component.cast_spell(current_spell, input_component.get_cast_input())
