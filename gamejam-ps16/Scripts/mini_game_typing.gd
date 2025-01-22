extends Node2D

@export var up_image: Texture2D
@export var down_image: Texture2D
@export var right_image: Texture2D
@export var left_image: Texture2D

enum button{UP,DOWN,LEFT,RIGHT}

@export var buttons : Array[int] = []
@export var buttons_sprites : Array[Sprite2D] = []

var next_button : String = "move_up"
var correct_button_presses: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set string to random variables
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#check for array size 
	for n in buttons.size():
		buttons[n] = rng.randi_range(0,4)
		buttons_sprites[n].texture = _set_button_images(buttons[n])
	_set_next_button()

#converts button ints into button images
func _set_button_images(num:int) -> Texture2D:
	if(num == button.UP):
		return up_image
	if(num == button.DOWN):
		return down_image
	if(num == button.RIGHT):
		return right_image
	return left_image

#converts button ints into strings for input collection
func _set_next_button():
	if(correct_button_presses >= buttons.size()):
		return
	if(buttons[correct_button_presses] == button.UP):
		next_button = "move_up"
	elif(buttons[correct_button_presses] == button.DOWN):
		next_button = "move_down"
	elif(buttons[correct_button_presses] == button.RIGHT):
		next_button = "move_right"
	else:
		next_button = "move_left"

func _minigame_timer_timeout():
	print("Mini game end")
	if(correct_button_presses == buttons.size()):
		print("Mini game win")
		get_parent()._minigame_win()
	else:
		print("Mini game lose")
		get_parent()._minigame_lose()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(correct_button_presses < buttons.size()):
		if(Input.is_action_just_pressed(next_button)):
			correct_button_presses += 1
			_set_next_button()
