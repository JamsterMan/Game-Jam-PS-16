extends Button

@export var sound_effects: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(self._button_pressed)

func _button_pressed():
	sound_effects.play(0)
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
