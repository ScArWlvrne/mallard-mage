extends Area2D

@export var speed: float = 300.0  # pixels per second
var velocity: Vector2 = Vector2.ZERO


func shoot(start_position: Vector2, angle_radians: float) -> void:
	global_position = start_position       # Set where the fireball spawns
	rotation = angle_radians               # Visually rotate it
	velocity = Vector2.RIGHT.rotated(angle_radians) * speed  # Move in that direction
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func _on_time_stop_triggered(active: bool):
	set_physics_process(not active)
