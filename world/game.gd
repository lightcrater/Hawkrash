extends Node2D

const ENEMY = preload("uid://cuf56mueiga5v")

var bird_spawn_rate:float = 2

func _on_bird_spawner_timeout() -> void:
	var new_bird = ENEMY.instantiate()
	add_child(new_bird)
	$"Bird spawner".start(randf_range(bird_spawn_rate,bird_spawn_rate+4))
