extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var timer_end = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await themed_timer.Timer(5.0)
	#after this is completed...
	timer_end = true 


func _process(delta: float) -> void:
	if buttons_pressed == 5:
		WinSfx.playWinSFX()
		Trasition.change_scene("res://Scenes/level_scene.tscn")
	
	if timer_end:
		Global.lives -= 1
		if Global.lives == -1:
			MusicManager.playGameOverMusic()
			Trasition.change_scene("res://Scenes/gameover.tscn")
		else:
			Global.minigames_done -=1
			LoseSfx.playLoseSFX()
			Trasition.change_scene("res://Scenes/level_scene.tscn")
			
