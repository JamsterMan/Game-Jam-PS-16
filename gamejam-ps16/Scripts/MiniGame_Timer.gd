extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeout.connect(get_parent()._minigame_timer_timeout)
	
func _hide_info() -> void:
	get_child(0).set_visible(false)

func _show_info() -> void:
	get_child(0).set_visible(true)
