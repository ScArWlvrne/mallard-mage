class_name TimeStopComponent
extends Node

signal time_stop_triggered(active: bool)

@export var particle_scene: PackedScene
@onready var gray_filter := get_tree().get_root().get_node("/root/TestChamber/BackgroundLayer/ColorRect")
var is_time_stopped: bool = false

func _spawn_particles():
	if particle_scene:
		var particles = particle_scene.instantiate()
		particles.global_position = get_parent().get_parent().global_position
		var player_layer = get_tree().current_scene.get_node("PlayerLayer")
		player_layer.add_child(particles)
		
		var particles_node = particles.get_node("GPUParticles2D")
		particles_node.emitting = true

func cast() -> void:
	is_time_stopped = !is_time_stopped
	gray_filter.visible = !gray_filter.visible
	
	if is_time_stopped:
		print("Time stop triggered!")
		emit_signal("time_stop_triggered", is_time_stopped)
		_spawn_particles()
	else:
		print("Time resumed.")
		emit_signal("time_stop_triggered", is_time_stopped)
