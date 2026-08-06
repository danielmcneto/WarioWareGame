extends TextureButton
@onready var parent = $".."
var randomX = RandomNumberGenerator.new().randi_range(85, 935)
var randomY = RandomNumberGenerator.new().randi_range(140, 445)
func _init() -> void:
	position.x = randomX
	position.y = randomY

func _on_pressed() -> void: #YOU NEED TO CONNECT THIS SIGNAL FROM THE TAB NEXT TO INSPECTOR!!
	hide()
	parent.buttons_pressed += 1
