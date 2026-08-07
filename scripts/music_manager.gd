extends Node2D

const zero_volume = -80

@onready var audio = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var a = audio.stream as AudioStreamSynchronized
	a.set_sync_stream_volume(0, 10)
	a.set_sync_stream_volume(1, -100)
	audio.play()
	
func playGameMusic() -> void:
	var a = audio.stream as AudioStreamSynchronized
	audio.play()
	a.set_sync_stream_volume(0, lerp(10, -100, 0.5))
	a.set_sync_stream_volume(2, lerp(10, -100, 0.5))
	a.set_sync_stream_volume(1, lerp(-100, 10, 1))

func playMenuMusic() -> void:
	var a = audio.stream as AudioStreamSynchronized
	audio.play()
	a.set_sync_stream_volume(1, lerp(10, -100, 0.5))
	a.set_sync_stream_volume(2, lerp(10, -100, 0.5))
	a.set_sync_stream_volume(0, lerp(-100, 10, 1))

func playGameOverMusic() -> void:
	var a = audio.stream as AudioStreamSynchronized
	audio.play()
	a.set_sync_stream_volume(1, lerp(10, -100, 0.5))
	a.set_sync_stream_volume(0, lerp(-100, 10, 0.5))
	a.set_sync_stream_volume(2, lerp(-100, 10, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
