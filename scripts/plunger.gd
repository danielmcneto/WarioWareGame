extends Sprite2D

var plungeds = 0
@onready var themed_timer: Node2D = $"../ThemedTimer"
@onready var sfx = $AudioStreamPlayer2D
var timer_end = false

var limit_top := 250.0
var limit_bottom := 450.0

var ready_to_dive := false 

func _ready() -> void:
	
	await themed_timer.Timer(5.0)
	#after this is completed...
	timer_end = true 

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_y = get_global_mouse_position().y
		
		position.y = clamp(mouse_y, limit_top, limit_bottom)
		
		if position.y <= limit_top + 20:
			
			ready_to_dive = true
			
		if ready_to_dive and position.y >= limit_bottom - 20:
			if plungeds >= 0.5 * Global.minigames_done:
				WinSfx.playWinSFX()
				Trasition.change_scene("res://scenes/level_scene.tscn")
				return
			sfx.play()
			plungeds += 1
			ready_to_dive = false
			await sfx.finished
	else:
		ready_to_dive = false
	
	if timer_end:
		Global.lives -= 1
		if Global.lives == -1:
			MusicManager.playGameOverMusic()
			Trasition.change_scene("res://Scenes/gameover.tscn")
		else:
			Global.minigames_done -=1
			LoseSfx.playLoseSFX()
			Trasition.change_scene("res://Scenes/level_scene.tscn")
			
		
