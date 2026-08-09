extends Node2D
@onready var sfx = $AudioStreamPlayer2D

@onready var themed_timer: Node2D = $"../ThemedTimer"
@onready var hit_effect: Sprite2D = $"../hitEffect"

var timer_end = false

var clicks = 0

var can_swing = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await themed_timer.Timer(5.0)
	#after this is completed...
	timer_end = true 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and can_swing:
		_smack()
		clicks += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if clicks >= 0.5 * Global.minigames_done:
		can_swing = false
	if timer_end:
		Global.lives -= 1
		if Global.lives == -1:
			MusicManager.playGameOverMusic()
			Trasition.change_scene("res://Scenes/gameover.tscn")
		else:
			Global.minigames_done -=1
			LoseSfx.playLoseSFX()
			Trasition.change_scene("res://Scenes/level_scene.tscn")
	
func _check_win() -> void:
	if clicks >= 0.5 * Global.minigames_done:
		can_swing = false
		WinSfx.playWinSFX()
		Trasition.change_scene("res://Scenes/win_scene.tscn")
	
func _smack() -> void:
	var tween = get_tree().create_tween()
	
	#swing hammer
	tween.tween_property(self, "rotation_degrees", -90.0, 0.1)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(func(): hit_effect.visible = true)
	tween.tween_callback(sfx.play)
	
	# swing back hammer
	tween.tween_property(self, "global_rotation", 0.0, 0.2)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.1)
	tween.tween_callback(func(): hit_effect.visible = false)
	tween.tween_interval(0.3)
	
	tween.tween_callback(_check_win)
	
	
