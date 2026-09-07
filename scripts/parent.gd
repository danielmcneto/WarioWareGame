extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var timer_end = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for i in range(Global.minigames_done * 0.5):
		Spawn_bomb()
	await themed_timer.Timer(5.0)
	
	#after this is completed...
	timer_end = true 

func Spawn_bomb() -> void:
	var new_bomb = $bomb.duplicate()
	
	# 2. Adiciona a cópia na cena
	add_child(new_bomb)

	#new_bomb.position = Vector2(randf_range(100, 500), randf_range(100, 500))
	
	new_bomb.visible = true

func _process(delta: float) -> void:
	if buttons_pressed == Global.minigames_done * 0.5:
		WinSfx.playWinSFX()
		Trasition.change_scene("res://Scenes/win_scene.tscn")
	
	if timer_end:
		Global.lives -= 1
		if Global.lives == -1:
			MusicManager.playGameOverMusic()
			Trasition.change_scene("res://Scenes/gameover.tscn")
		else:
			Global.minigames_done -=1
			LoseSfx.playLoseSFX()
			Trasition.change_scene("res://Scenes/level_scene.tscn")
			
