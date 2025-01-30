extends Control

@export var sound_effects: AudioStreamPlayer
@export var play_button: Button
@export var how_to_button: Button
@export var back_button: Button
@export var how_to_screen: ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(self._play_button_pressed)
	how_to_button.pressed.connect(self._how_to_button_pressed)
	back_button.pressed.connect(self._back_button_pressed)

func _play_button_pressed():
	sound_effects.play(0)
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")

func _how_to_button_pressed():
	sound_effects.play(0)
	await get_tree().create_timer(0.1).timeout
	#open screen
	how_to_screen.set_visible(true)

func _back_button_pressed():
	sound_effects.play(0)
	await get_tree().create_timer(0.1).timeout
	#close screen
	how_to_screen.set_visible(false)
