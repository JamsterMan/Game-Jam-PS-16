extends Node2D

func _minigame_timer_timeout():
	print("Mini game start")
	#hide info screen
	get_child(0)._hide_info()
	#show and activate minigame
	get_child(1).set_visible(true)
	get_child(1).set_process_mode(PROCESS_MODE_INHERIT)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set everything to chosen mini game?
	pass # Replace with function body.


func _minigame_win():
	get_child(2).set_visible(true)

func _minigame_lose():
	get_child(3).set_visible(true)
