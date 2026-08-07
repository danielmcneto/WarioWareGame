extends Node2D

@onready var sfx = $AudioStreamPlayer2D
@onready var scr = $Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	scr.text = "Score: " + str(Global.minigames_done)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tryagain_button_pressed() -> void:
	sfx.play()
	await sfx.finished
	MusicManager.playGameMusic()
	Global.lives = 5
	var i = RandomNumberGenerator.new().randi_range(1,3)
	Trasition.change_scene("res://Scenes/level_scene.tscn")


func _on_mainmenu_button_pressed() -> void:
	sfx.play()
	await sfx.finished
	MusicManager.playMenuMusic()
	Trasition.change_scene("res://scenes/title_screen.tscn")
