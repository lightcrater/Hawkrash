extends AnimatedSprite2D

var speed:float = randf_range(0.3,1)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	position.x -= speed
	if position.x < -2600:
		position.x = 2300

func _ready() -> void:
	var sprite = randi_range(1,6)
	$".".play(str(sprite))
