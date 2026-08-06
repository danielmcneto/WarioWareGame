extends Sprite2D

var plungeds = 0
@onready var themed_timer: Node2D = $"../ThemedTimer"
@onready var sfx = $AudioStreamPlayer2D
var timer_end = false

# Limites da privada
var limit_top := 250.0
var limit_bottom := 450.0

var ready_to_dive := false 

func _ready() -> void:
	
	await themed_timer.Timer(5.0)
	#after this is completed...
	timer_end = true 

func _process(_delta: float) -> void:
	# 1. SÓ FUNCIONA SE O JOGADOR ESTIVER SEGURANDO O CLIQUE
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_y = get_global_mouse_position().y
		
		position.y = clamp(mouse_y, limit_top, limit_bottom)
		
		if position.y <= limit_top + 20:
			ready_to_dive = true
			
		if ready_to_dive and position.y >= limit_bottom - 20:
			sfx.play()
			plungeds += 1
			ready_to_dive = false # RESETA O ESTADO! Ele é obrigado a subir tudo de novo
			print("DESENTOPOU! Contagem: ", plungeds)
			
			# Toca um barulho de água de privada / efeito visual aqui
			
			if plungeds >= 5:
				print("PRIVADA DESENTUPIDA! VITÓRIA!")
				get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
	else:
		ready_to_dive = false
	
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -=1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
		
