class_name Enemy extends CharacterBody2D 

enum State { WALKING, DEAD, } 
const WALK_SPEED = 12.0 

var _state := State.WALKING 
var is_paused: bool = false 

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity") 
@onready var platform_detector := $PlatformDetector as RayCast2D 
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D 
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D 
@onready var sprite := $Sprite2D as Sprite2D 
@onready var animation_player := $AnimationPlayer as AnimationPlayer 
@onready var hitbox := $KillCollision


func pause():
	is_paused = true
	velocity = Vector2.ZERO  # stop movement immediately

func resume():
	is_paused = false

func _ready() -> void:
	self.add_to_group("Enemies")
	hitbox.body_entered.connect(_on_body_entered)
	
	var time_stop_component = get_tree().get_first_node_in_group("TimeStopComponent")
	if time_stop_component:
		time_stop_component.time_stop_triggered.connect(_on_time_stop_triggered)

func _on_time_stop_triggered(active: bool) -> void:
	is_paused = active
func _process(_delta) -> void: 
	pass
	
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
@export var movement_component: MovementComponent 
@export var mana_potion_scene: PackedScene

var direction: int = -1  # start going left

func _physics_process(delta: float) -> void:
	if is_paused:
		return  # skip logic when paused
	gravity_component.handle_gravity(self, delta)

	# Move based on current direction
	movement_component.handle_horizontal_movement(self, direction)

	move_and_slide()

	# Turn around when hitting a wall
	if is_on_wall():
		direction *= -1

	move_and_slide()
	
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
	
	if mana_potion_scene and randf() < 0.3:
		var potion = mana_potion_scene.instantiate()
		get_parent().add_child(potion)
		potion.global_position = global_position
	
	queue_free() 
	
func get_new_animation() -> StringName: 
	var animation_new: StringName 
	if _state == State.WALKING: 
		if velocity.x == 0: 
			animation_new = &"idle" 
		else: animation_new = &"walk" 
	else: animation_new = &"destroy" 
	return animation_new

func _on_body_entered(body: Node) -> void:
	if body is Player:
		print("Touched player")
		get_tree().change_scene_to_file("res://levels/gameover/game_over.tscn")
