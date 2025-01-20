extends Node2D

@export var person_count : int = 4
@export var minigame_length : float = 3
@export var target_area : Area2D
@export var minigame_timer: Timer

func _minigame_timer_timeout():
	print("Mini game end")
	if(target_area.has_overlapping_areas() ):
		print("Mini game win")
		get_parent()._minigame_win()
	else:
		print("Mini game lose")
		get_parent()._minigame_lose()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set minigame info here
	minigame_timer.start(minigame_length)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for n in person_count:
		var x = rng.randf_range(-40,40)
		var y = rng.randf_range(-25,25)
		get_child(n).global_position = Vector2.UP*y*10 + Vector2.RIGHT*x*10
