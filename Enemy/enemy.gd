extends CharacterBody2D

var speeds = [400,800]
var speed:int
var angle: float
var dir: Vector2
var turnStr: float
var turnmod: float

var boostspeeds = [900,1200]
var boosting = false
var boost_len:float
var max_boost_len:int
var boost_cost:float
var boost_regen:float

var targetAngle: float
var target: Vector2
var player

func _ready() -> void:
	speed = randi_range(speeds[0],speeds[1])
	turnStr = randf_range(0.02,0.1)
	player = get_tree().get_nodes_in_group("player")
	max_boost_len = randi_range(15,25)
	boost_cost = randf_range(0.2,0.4)
	boost_regen = randf_range(0.1,0.3)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:

	targetAngle = get_angle_to(target)
	if targetAngle < 0:
		angle -= turnStr*turnmod
	elif targetAngle >0:
		angle += turnStr*turnmod

	dir = Vector2(cos(angle),sin(angle)).normalized()

	velocity = -dir * speed

	spriteManager()
	boostManager()

	move_and_slide()

func spriteManager()->void:
	look_at(velocity.normalized()+position)
	if velocity.x < -1:
		$sprite.flip_v = true
	else:
		$sprite.flip_v = false

	if boosting:
		$sprite.play("charge")
	else:
		$sprite.play("fly")

func boostManager()->void:
	if boost_len >= max_boost_len and boosting == false:
		boosting = true
		target = player[0].global_position

	if boosting == false and boost_len <= max_boost_len:
		turnmod = 1
		speed = randi_range(speeds[0],speeds[1])
		boost_len += boost_regen

	elif boosting == true and boost_len > 0:
		speed = randi_range(boostspeeds[0],boostspeeds[1])
		boost_len -= boost_cost
		turnmod = 2
		
	elif boosting == true and boost_len <= 0:
		turnmod = 1
		boosting = false
		speed = randi_range(speeds[0],speeds[1])

@warning_ignore("unused_parameter")
func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var playerarea = area.get_parent()
	if playerarea.is_in_group("player") and playerarea.boosting == true and boosting == false:
		playerarea.add_point(1)
		queue_free()
	elif playerarea.is_in_group("player") and playerarea.boosting == false and boosting == true:
		get_tree().change_scene_to_file("res://Titlescreen/Title screen.tscn")
