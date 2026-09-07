extends TextureButton
@onready var parent = $".."
@onready var sfx = $"../AudioStreamPlayer2D"

var randomX = randi_range(85, 935)
var randomY = randi_range(140, 445)

func _ready() -> void:
	randomize() # Prepara a semente aleatória global do jogo
	position.x = randomX
	position.y = randomY

func _on_pressed() -> void: #YOU NEED TO CONNECT THIS SIGNAL FROM THE TAB NEXT TO INSPECTOR!!
	sfx.play()
	hide()
	parent.buttons_pressed += 1
