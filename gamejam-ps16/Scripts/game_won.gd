extends Control

@export var minigame_count_label: Label

func _set_minigame_count_label(num:int):
	minigame_count_label.text = str(num)
