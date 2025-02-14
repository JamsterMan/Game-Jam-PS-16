extends Node2D

@export var person_count : int = 4
@export var min_minigame_length : float = 2
@export var minigame_time_steps : float = 0.5

@export var minigame_timer: Timer
@export var target_area : Area2D

var max_height = 25
var min_height = -25
var max_width = 40
var min_width = -25
var parent

#minigame is over -> figure out if game was completed or not
func _minigame_timer_timeout():
	if(target_area.has_overlapping_areas() ):
		parent._death_sound()
		parent._minigame_win()
	else:
		parent._minigame_lose()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var vec = Vector2.ZERO
	for n in person_count:
		var x = rng.randf_range(min_width,max_width)
		var y = rng.randf_range(min_height,max_height)
		if(n == 0):
			vec = Vector2.UP*y*10 + Vector2.RIGHT*x*10
		get_child(n).global_position = Vector2.UP*y*10 + Vector2.RIGHT*x*10
	
	#adjust timer based on distance
	var minigame_length = min_minigame_length + (minigame_time_steps* vec.distance_to(Vector2.ZERO)/100)-parent._get_time_reduction()
	minigame_timer.start(minigame_length)
	parent._set_minigame_visual_timer(minigame_length)
