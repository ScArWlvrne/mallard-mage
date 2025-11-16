class_name FireballComponent
extends Area2D

@export var fireball_scene: PackedScene
@export var speed: float = 300.0  # pixels per second
var velocity: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func cast() -> void:
	print("I cast fireball!")
	var player = get_parent().get_parent()
	var fireball = fireball_scene.instantiate()
	get_tree().current_scene.add_child(fireball)
	var position = player.global_position # TODO: replace with arrow position when reimplemented
	var angle = 0 # TODO: replace with arrow angle later
	
	fireball.shoot(position, angle)
	
	
func shoot(start_position: Vector2, angle_radians: float) -> void:
	global_position = start_position       # Set where the fireball spawns
	rotation = angle_radians               # Visually rotate it
	velocity = Vector2.RIGHT.rotated(angle_radians) * speed  # Move in that direction
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
