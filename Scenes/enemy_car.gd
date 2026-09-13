extends Area2D

@onready var speed = (200.0 * Global.minigames_done) / 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if speed >= 1000:
		speed = 1000
	if speed == 0:
		speed = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	if global_position.y > 750: 
		queue_free()
