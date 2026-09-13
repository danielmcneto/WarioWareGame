extends Area2D

@export var lerp_speed : float = 45.0
@export var max_steering_angle : float = 25.0

@onready var hit_effect: Sprite2D = $hitEffect
@onready var sfx = $"../AudioStreamPlayer2D"

var alive = true

func _ready() -> void:
	var start_x = clamp(get_global_mouse_position().x, 350.0, 800.0)
	global_position.x = start_x

func _process(delta: float) -> void:
	if alive:
		var target_x = get_global_mouse_position().x
		target_x = clamp(target_x, 350.0, 800.0) 
	
		var prev_x = global_position.x
		global_position.x = lerp(global_position.x, target_x, lerp_speed * delta)
	
		var steer_direction = (global_position.x - prev_x)
		rotation_degrees = lerp(rotation_degrees, steer_direction * 8.0, lerp_speed * delta)
		rotation_degrees = clamp(rotation_degrees, -max_steering_angle, max_steering_angle)

func _on_area_entered(area: Area2D) -> void:
	if alive:
		die()

func die() -> void:
	alive = false
	sfx.play()
	hit_effect.visible = true
	
	await get_tree().create_timer(0.5).timeout
	
	Global.lives -= 1
	if Global.lives == -1:
		MusicManager.playGameOverMusic()
		Trasition.change_scene("res://Scenes/gameover.tscn")
	else:
		Global.minigames_done -= 1
		LoseSfx.playLoseSFX()
		Trasition.change_scene("res://Scenes/level_scene.tscn")
