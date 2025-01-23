extends Node2D

@export var minigames : Array[String] = [] 
@export var minigame_info_timer: Timer
@export var next_minigame_timer: Timer
@export var minigame_info: TextureRect
@export var minigame_win: TextureRect
@export var minigame_lose: TextureRect
var minigame

func _minigame_timer_timeout():
	print("Mini game start")
	#hide info screen
	#minigame_info_timer._hide_info()
	minigame_info.set_visible(false)
	#show and activate minigame
	minigame.set_visible(true)
	minigame.set_process_mode(PROCESS_MODE_INHERIT)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start with random minigame
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#var minigame_path_index = rng.randi_range(0,minigames.size()-1)
	#var next_minigame = load(minigames[minigame_path_index])
	#minigame = next_minigame.instantiate()
	#add_child(minigame)
	minigame = get_child(3)
	pass # Replace with function body.

func _minigame_win():
	minigame_win.set_visible(true)
	next_minigame_timer.start(2)
	#go to next minigame after timer

func _minigame_lose():
	minigame_lose.set_visible(true)
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
	var minigame_path_index = rng.randi_range(0,minigames.size()-1)
	var next_minigame = load(minigames[minigame_path_index])
	minigame = next_minigame.instantiate()
	add_child(minigame)

#func _set_minigame_info(string?):
