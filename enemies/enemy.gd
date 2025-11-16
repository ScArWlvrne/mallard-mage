# Enemy.gd
class_name Enemy
extends CharacterBody2D

enum State { WALKING, DEAD }

const WALK_SPEED := 10.0

var _state := State.WALKING
var is_paused: bool = false

@onready var gravity: int = int(ProjectSettings.get("physics/2d/default_gravity"))
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var movement_component: MovementComponent

var direction: int = -1  # -1 = left, 1 = right

func _process(_delta):
	if Input.is_action_pressed("time_stop"):
		is_paused = true
	if is_paused:
		velocity.x = 0
		velocity.y = 0
		return

func _physics_process(delta: float) -> void:
	if is_paused:
		return

	# Apply gravity via your component
	if gravity_component:
		gravity_component.handle_gravity(self, delta)
	else:
		# fallback gravity if component missing
		velocity.y += gravity * delta

	# Move horizontally according to current direction
	if movement_component:
		movement_component.handle_horizontal_movement(self, direction)
	else:
		# fallback simple movement if component missing:
		velocity.x = WALK_SPEED * direction

	move_and_slide()

	# Turn around when hitting a wall
	if is_on_wall():
		direction *= -1

	# Turn around before falling off a ledge
	if direction < 0 and not floor_detector_left.is_colliding():
		direction = 1
	elif direction > 0 and not floor_detector_right.is_colliding():
		direction = -1

	# Flip sprite (small scale, not huge)
	if velocity.x > 0.0:
		sprite.scale.x = 0.8
	elif velocity.x < 0.0:
		sprite.scale.x = -0.8

func destroy() -> void:
	_state = State.DEAD
	velocity = Vector2.ZERO

func get_new_animation() -> StringName:
	if _state == State.WALKING:
		return "idle" if velocity.x == 0 else "walk"
	return "destroy"

func hit_by_fireball() -> void:
	# ignore repeated hits
	if _state == State.DEAD:
		return

	print("Enemy hit by fireball:", self.name)
	_state = State.DEAD
	velocity = Vector2.ZERO

	# disable collision shapes (safe check)
	var cs := $CollisionShape2D if has_node("CollisionShape2D") else null
	if cs:
		cs.disabled = true

	# play death animation if present, then free
	if animation_player:
		animation_player.play("destroy")
		await animation_player.animation_finished
		queue_free()
	else:
		queue_free()
		
