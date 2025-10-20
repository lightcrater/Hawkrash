extends Node2D

const cloud_sprite = preload("uid://dbbsjwj1fvdp5")
var cloud: AnimatedSprite2D
var cloud_pos: Vector2

func _ready() -> void:
	for i in range(50):
		cloud = cloud_sprite.instantiate()
		cloud_pos = Vector2(randi_range(-2500,2000),randi_range(-60,60))
		cloud.position = cloud_pos
		add_child(cloud)
