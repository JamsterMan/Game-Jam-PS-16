extends Area2D

@export var aim_speed : int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if(Input.is_action_pressed("move_up")):
		direction += Vector2.UP
	if(Input.is_action_pressed("move_down")):
		direction += Vector2.DOWN
	if(Input.is_action_pressed("move_left")):
		direction += Vector2.LEFT
	if(Input.is_action_pressed("move_right")):
		direction += Vector2.RIGHT
	
	translate(aim_speed * direction * delta)
