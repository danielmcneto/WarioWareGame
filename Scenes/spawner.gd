extends Node2D

const ENEMY_CAR_SCENE = preload("res://Scenes/enemy_car.tscn")

# 1. Defina as posições X das 3 faixas da sua pista (ajuste os números pro seu jogo!)
const LANE_X_POSITIONS : Array[float] = [400.0, 550.0, 700.0]
const SPAWN_Y_POSITION : float = -50.0 # Nascem acima da tela

@onready var themed_timer: Node2D = $"../ThemedTimer"

@onready var timer = $Timer

var timer_end = false;

func _ready() -> void:
	spawn_wave()
	await themed_timer.Timer(5.0)
	timer_end = true 

func _process(delta: float) -> void:
	if timer_end:
		WinSfx.playWinSFX()
		Trasition.change_scene("res://Scenes/win_scene.tscn")

func spawn_wave() -> void:
	# 2. Copia e embaralha o array de faixas
	var available_lanes = LANE_X_POSITIONS.duplicate()
	available_lanes.shuffle()
	
	# 3. Sorteia 1 ou 2 carros
	var cars_to_spawn = randi_range(1, 2)
	
	# 4. Spawna nas posições X sorteadas
	for i in range(cars_to_spawn):
		var new_car = ENEMY_CAR_SCENE.instantiate()
		
		# Define a posição (X da faixa sorteada, Y fixo no topo)
		var spawn_x = available_lanes[i]
		new_car.global_position = Vector2(spawn_x, SPAWN_Y_POSITION)
		
		add_child(new_car)
		
	timer.start(2)

func _on_timer_timeout() -> void:
	spawn_wave()
