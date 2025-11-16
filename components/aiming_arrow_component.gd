extends Node2D
class_name AimingArrowComponent

@export var arc_degrees: float = 90.0
@export var speed: float = 2.0
@export var offset: Vector2 = Vector2(0, -8)  # offset from player position

var time: float = 0.0
var direction: int = 1  # 1 = facing right, -1 = facing left

func _process(delta: float) -> void:
	time += delta * speed
	var angle_rad = deg_to_rad(arc_degrees / 2.0) * sin(time)
	rotation = angle_rad
	scale.x = direction  # Flip horizontally if needed
	scale.y = direction  # Flip vertically too, if needed

func set_facing_direction(dir: int) -> void:
	direction = dir

func reset_time() -> void:
	time = 0.0
