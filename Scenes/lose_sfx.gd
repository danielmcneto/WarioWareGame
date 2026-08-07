extends Node2D
@onready var sfx = $AudioStreamLose

func playLoseSFX() -> void:
	sfx.play()
