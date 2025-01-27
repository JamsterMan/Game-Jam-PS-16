extends Node2D

@export var minigames : Array[String] = [] 
@export var minigame_info_timer: Timer
@export var next_minigame_timer: Timer
@export var minigame_info: TextureRect
@export var minigame_win: TextureRect
@export var minigame_lose: TextureRect
@export var minigame_timer_visual: TextureProgressBar

var minigame
var last_minigame_path_index: int = 0
var start_visual_timer: bool = false
var time_past: float = 0

func _minigame_timer_timeout():
	print("Mini game start")
	#hide info screen
	minigame_info.set_visible(false)
	#show and activate minigame
	minigame.set_visible(true)
	minigame.set_process_mode(PROCESS_MODE_INHERIT)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start with random minigame
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	last_minigame_path_index = rng.randi_range(0,minigames.size()-1)
	var next_minigame = load(minigames[last_minigame_path_index])
	#var next_minigame = load(minigames[2])
	
	minigame = next_minigame.instantiate()
	add_child(minigame)
	pass # Replace with function body.

func _minigame_win():
	minigame_win.set_visible(true)
	next_minigame_timer.start(2)
	#go to next minigame after timer

func _minigame_lose():
	minigame_lose.set_visible(true)
	minigame.set_visible(false)
	minigame.set_process_mode(PROCESS_MODE_DISABLED)
	#game over

func _next_minigame_timer_timeout():
	print("Next minigame loading")
	_reset_minigame()

func _reset_minigame():
	minigame_win.set_visible(false)
	#set up minigame info screen
	#minigame_info_timer._show_info()
	minigame_info.set_visible(true)
	minigame_info_timer.start(1)
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
	var next_minigame = load(minigames[minigame_path_index])
	minigame = next_minigame.instantiate()
	add_child(minigame)

#func _set_minigame_info(string?):

func _set_minigame_visual_timer(time:int):
	minigame_timer_visual.max_value = time
	minigame_timer_visual.value = time
	time_past = 0
	start_visual_timer = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(start_visual_timer):
		time_past += delta
		if(time_past >= 0.5):
			print(time_past)
			time_past -= 0.5
			minigame_timer_visual.value -= 0.5
