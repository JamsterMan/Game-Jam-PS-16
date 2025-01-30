extends Node2D

@export var min_presses: int = 2
@export var max_presses: int = 5
var presses_needed: int = 3
var correct_presses: int = 0

enum button{UP,DOWN,LEFT,RIGHT}

@export var min_minigame_length : float = 2
@export var minigame_time_steps : float = 0.5
@export var minigame_timer: Timer

@export var target_postions : Array[int] = []
#max 4
@export var char_sprites : Array[Sprite2D] = []
@export var target_sprites : Array[Sprite2D] = []

@export var char_target: Texture2D
@export var char_fake: Texture2D
@export var char_target_hit: Texture2D

var next_button : String = "move_up"
var parent: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	#set string to random variables
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	presses_needed = rng.randi_range(min_presses,max_presses)
	#set buttons for each round
	for n in presses_needed:
		target_postions[n] = rng.randi_range(0,3)
		target_sprites[n].texture = char_target
	#set sprites for first button press
	char_sprites[target_postions[0]].texture = char_target
	_set_next_button()
	#adjust timer based on number of button presses
	var minigame_length = min_minigame_length + minigame_time_steps*(presses_needed-min_presses)
	minigame_timer.start(minigame_length)
	get_parent()._set_minigame_visual_timer(minigame_length)

#converts button ints into button images
func _set_next_images():
	if(correct_presses >= presses_needed):
		char_sprites[target_postions[correct_presses-1]].texture = char_target_hit
		parent._death_sound()
		return
	for n in char_sprites.size():
		if(target_postions[correct_presses] == n):
			char_sprites[n].texture = char_target
		else:
			char_sprites[n].texture = char_fake

#converts button ints into strings for input collection
func _set_next_button():
	if(correct_presses >= presses_needed):
		return
	if(target_postions[correct_presses] == button.UP):
		next_button = "move_up"
	elif(target_postions[correct_presses] == button.DOWN):
		next_button = "move_down"
	elif(target_postions[correct_presses] == button.RIGHT):
		next_button = "move_right"
	else:
		next_button = "move_left"

func _set_target_hit():
	target_sprites[correct_presses].texture = char_target_hit
	parent._sword_sound()

#minigame is over -> figure out if game was completed or not
func _minigame_timer_timeout():
	if(correct_presses >= presses_needed):
		get_parent()._minigame_win()
	else:
		get_parent()._minigame_lose()
		
		# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(correct_presses < presses_needed):
		if(Input.is_action_just_pressed(next_button)):
			_set_target_hit()
			correct_presses += 1
			_set_next_button()
			_set_next_images()
				
