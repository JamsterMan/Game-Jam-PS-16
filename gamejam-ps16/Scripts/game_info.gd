extends Control

@export var weapons: Array[Texture2D] = []
@export var weapon_sprite: TextureRect

@export var animation: AnimationPlayer

func _set_weapon_image(num:int):
	weapon_sprite.texture = weapons[num]

func _reset_animation():
	animation.queue("minigame_info_animation")
