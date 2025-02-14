extends Node2D

@export var minigames : Array[String] = [] 
@export var minigame_info_timer: Timer
@export var next_minigame_timer: Timer
@export var minigame_info: Control
@export var minigame_win: Control
@export var minigame_lose: Control
@export var minigame_timer_visual: TextureProgressBar
@export var sound_effects: AudioStreamPlayer
@export var minigame_background: TextureRect

var minigame
var last_minigame_path_index: int = 0
var start_visual_timer: bool = false
var time_past: float = 0
var minigame_count:int = 0

@export var minigame_time_reduction: float = 0.05
@export var minigame_time_reduction_interval: int = 10

#minigame starts here
func _minigame_timer_timeout():
	#hide info screen
	minigame_info.set_visible(false)
	#show and activate minigame
	start_visual_timer = true
	minigame.set_visible(true)
	minigame.set_process_mode(PROCESS_MODE_INHERIT)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start with random minigame
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	last_minigame_path_index = rng.randi_range(0,minigames.size()-1)
	var next_minigame = load(minigames[last_minigame_path_index])
	minigame_info._set_weapon_image(last_minigame_path_index)
	minigame_background._change_background(last_minigame_path_index)
	
	minigame = next_minigame.instantiate()
	add_child(minigame)

func _minigame_win():
	minigame_count += 1
	minigame_win._set_minigame_count_label(minigame_count)
	start_visual_timer = false
	minigame_win.set_visible(true)
	next_minigame_timer.start(2)
	#go to next minigame after timer

func _minigame_lose():
	minigame_lose.set_visible(true)
	minigame.set_visible(false)
	minigame.set_process_mode(PROCESS_MODE_DISABLED)
	#game over

func _next_minigame_timer_timeout():
	_reset_minigame()

func _reset_minigame():
	minigame_win.set_visible(false)
	#set up minigame info screen
	minigame_info.set_visible(true)
	minigame_info_timer.start(1.5)
	#set up minigame
	minigame.queue_free()
	#choose game at semi random - try not to repeat games
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#0, size()-2 -> -2 to prevent repeat games
	var minigame_path_index = rng.randi_range(0,minigames.size()-2)
	if(minigame_path_index >= last_minigame_path_index):
		minigame_path_index += 1
	last_minigame_path_index = minigame_path_index
	#game 0 = aim, 1 = type, 2 = quicktime
	var next_minigame = load(minigames[minigame_path_index])
	minigame = next_minigame.instantiate()
	add_child(minigame)
	#reset minigame info animation
	minigame_info._set_weapon_image(minigame_path_index)
	minigame_background._change_background(minigame_path_index)
	minigame_info._reset_animation()

#func _set_minigame_info(string?):

func _set_minigame_visual_timer(time:int):
	minigame_timer_visual.max_value = time
	minigame_timer_visual.value = time
	time_past = 0.05

# Called every frame. 'delta' is the elapsed time since the previous frame.
# used to show the time remaining on screen
func _process(delta: float) -> void:
	if(start_visual_timer):
		time_past += delta
		if(time_past >= 0.05):
			time_past -= 0.05
			minigame_timer_visual.value -= 0.05

#reduce time given for minigames the more games are played
func _get_time_reduction() -> float:
	print(minigame_count/minigame_time_reduction_interval)
	return minigame_time_reduction*(minigame_count/minigame_time_reduction_interval)

func _death_sound():
	sound_effects._play_death_sound()

func _sword_sound():
	sound_effects._play_sword_sound()

func _magic_sound():
	sound_effects._play_magic_sound()
