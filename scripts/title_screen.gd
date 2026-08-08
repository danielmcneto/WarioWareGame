extends Node2D

@onready var sfx = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	sfx.play()
	get_tree().quit()


func _on_sart_button_pressed() -> void:
	sfx.play()
	Global.lives = 5
	await sfx.finished
	MusicManager.playGameMusic()
	Trasition.change_scene("res://Scenes/level_scene.tscn")
	Global.minigames_done = 1


func _on_setting_button_pressed() -> void:
	sfx.play()
	Trasition.change_scene("res://Scenes/settings.tscn")
