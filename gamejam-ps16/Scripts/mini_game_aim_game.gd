extends Node2D

func _minigame_timer_timeout():
	print("Mini game end")
	if(get_child(1).has_overlapping_areas() ):
		print("Mini game win")
		get_parent()._minigame_win()
	else:
		print("Mini game lose")
		get_parent()._minigame_lose()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
