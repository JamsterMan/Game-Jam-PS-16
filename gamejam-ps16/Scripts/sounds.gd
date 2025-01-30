extends AudioStreamPlayer

@export var death_sound: AudioStreamWAV
@export var sword_sound: AudioStreamWAV
@export var magic_sound: AudioStreamWAV
@export var button_sound: AudioStreamWAV
@export_range(-20, 10) var volume: float = 0
var poly = AudioStreamPolyphonic.new()
var sounds: AudioStreamPlaybackPolyphonic

var rng

func _ready() -> void:
	stream = poly
	play()
	sounds = get_stream_playback()
	rng = RandomNumberGenerator.new()
	rng.randomize()

func _play_button_sound():
	sounds.play_stream(button_sound,0,volume, 1.0)
	
func _play_death_sound():
	sounds.play_stream(death_sound,0,volume, rng.randf_range(0.9,1.1))

func _play_magic_sound():
	sounds.play_stream(magic_sound,0,volume+2, rng.randf_range(0.9,1.1))

func _play_sword_sound():
	sounds.play_stream(sword_sound,0,volume+2, rng.randf_range(0.9,1.1))
