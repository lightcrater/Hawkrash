extends CharacterBody2D

var mpos : Vector2
var dir: Vector2

var maxspeed = 500
var acceleration = 10
var speed:int

var maxboostspd = 1000
var boostaccel = 50
var boosting = false
var maxboost = 30
var boosttimer:float = maxboost

var score: int
var camera:Node2D

func  _ready() -> void:
	randomize()
	camera = get_node("Camera")
	

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	$CanvasLayer/TextureProgressBar.value = boosttimer
	
	mpos = get_global_mouse_position()
	dir = (mpos-self.position).normalized()
	
	if Input.is_action_pressed("mouse") and boosttimer > 0:
		boosting = true
		boosttimer -= 0.5
		$sprite.play("Boosting")
	elif Input.is_action_pressed("mouse") and boosttimer <=0:
		boosting = false
		$sprite.play("default")
	else:
		boosting = false
		$sprite.play("default")
		if boosttimer < maxboost:
			boosttimer += 0.4
	
	if speed > maxspeed and boosting == false:
		speed = maxspeed
	elif speed <= maxspeed and boosting == false:
		speed += acceleration
	elif speed > maxboostspd and boosting == true:
		speed = maxboostspd
	elif speed <= maxboostspd and boosting == true:
		speed += boostaccel
	
	if velocity.x < -1:
		$sprite.flip_v = true
	else:
		$sprite.flip_v = false
	
	if (position - mpos).length() >= 5:
		velocity = speed * dir
		look_at(velocity.normalized()+position)
		
		move_and_slide()

func add_point(point: int)->void:
	score += point
	$CanvasLayer/Points/Label.text = str(score)
