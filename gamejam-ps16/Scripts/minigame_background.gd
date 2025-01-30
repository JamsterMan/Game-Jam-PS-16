extends TextureRect

@export var backgrounds: Array[CompressedTexture2D] = []

func _change_background(index:int):
	texture = backgrounds[index]
