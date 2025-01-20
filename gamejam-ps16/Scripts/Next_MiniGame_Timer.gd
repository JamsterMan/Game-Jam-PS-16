extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeout.connect(get_parent()._next_minigame_timer_timeout)
