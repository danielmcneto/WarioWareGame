extends Node2D
@onready var sfx = $AudioStreamPlayer2D

func playWinSFX() -> void:
	sfx.play()
