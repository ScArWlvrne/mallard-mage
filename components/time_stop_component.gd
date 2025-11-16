class_name TimeStopComponent
extends Node

signal time_stop_triggered(active: bool)

@export var particle_scene: PackedScene
var is_time_stopped: bool = false

@onready var mana_component := get_parent().get_parent().get_node("ManaComponent")
@onready var mana_drain_timer: Timer = $ManaDrainTimer

func _ready() -> void:
	add_to_group("TimeStopComponent")

func _spawn_particles():
	if particle_scene:
		var particles = particle_scene.instantiate()
		particles.global_position = get_parent().get_parent().global_position
		get_tree().current_scene.add_child(particles)
		
		var particles_node = particles.get_node("GPUParticles2D")
		particles_node.emitting = true

func cast() -> void:
	is_time_stopped = !is_time_stopped
	emit_signal("time_stop_triggered", is_time_stopped)
	
	if is_time_stopped:
		if mana_component._subtract_mana(1):
			print("Time stop triggered!")
			_spawn_particles()
			mana_drain_timer.start()
		else:
			print("Not enough mana to start time stop.")
			is_time_stopped = false
	else:
		print("Time resumed.")
		mana_drain_timer.stop()

func _on_mana_drain_timer_timeout() -> void:
	if not mana_component._subtract_mana(1):
		print("Mana depleted — stopping time.")
		is_time_stopped = false
		emit_signal("time_stop_triggered", false)
		mana_drain_timer.stop()
