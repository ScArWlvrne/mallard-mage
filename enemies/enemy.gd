class_name Enemy extends CharacterBody2D


enum State {
	WALKING,
	DEAD,
}

const WALK_SPEED = 10.0

var _state := State.WALKING
var is_paused: bool = false

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer



func _process(_delta):
	if Input.is_action_pressed("time_stop"):
		is_paused = true
	if is_paused:
		print("Paused")
		velocity.x = 0
		velocity.y = 0
		return

#func _physics_process(delta: float) -> void:
	#if _state == State.WALKING and velocity.is_zero_approx() and not Input.is_action_pressed("time_stop"):
		#velocity.x = WALK_SPEED
	#velocity.y += gravity * delta
	#if not floor_detector_left.is_colliding():
		#velocity.x = WALK_SPEED
	#elif not floor_detector_right.is_colliding():
		#velocity.x = -WALK_SPEED
		

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
# @export var input_component: InputComponent
@export var movement_component: MovementComponent

var direction: int = -1  # -1 = left, 1 = right



func _physics_process(delta: float) -> void:
	# Apply gravity
	gravity_component.handle_gravity(self, delta)

	# Move horizontally based on direction
	movement_component.handle_horizontal_movement(self, direction)

	move_and_slide()

	# 1. TURN AROUND WHEN HITTING A WALL
	if is_on_wall():
		direction *= -1

	# 2. TURN AROUND WHEN WALKING OFF A LEDGE
	if direction < 0 and not floor_detector_left.is_colliding():
		# moving left but no floor on left → turn right
		direction = 1

	elif direction > 0 and not floor_detector_right.is_colliding():
		# moving right but no floor on right → turn left
		direction = -1

	if velocity.x > 0.0:
		sprite.scale.x = -10
	elif velocity.x < 0.0:
		sprite.scale.x = 10

	#var animation := get_new_animation()
	#if animation != animation_player.current_animation:
		#animation_player.play(animation)


func destroy() -> void:
	_state = State.DEAD
	velocity = Vector2.ZERO


func get_new_animation() -> StringName:
	var animation_new: StringName
	if _state == State.WALKING:
		if velocity.x == 0:
			animation_new = &"idle"
		else:
			animation_new = &"walk"
	else:
		animation_new = &"destroy"
	return animation_new
