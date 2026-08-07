extends Area2D
@onready var max_vel = 1000 * Global.minigames_done
@onready var smooth = 2

@onready var screen_size = get_viewport_rect().size
@onready var sprite = $Sprite2D

var randomX = RandomNumberGenerator.new().randi_range(200, 935)
var randomY = RandomNumberGenerator.new().randi_range(140, 445)

var dead = false

var rn_vel = Vector2.ZERO
var target_vel = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_change_dir()
	position.x = randomX
	position.y = randomY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rn_vel = rn_vel.lerp(target_vel, smooth * delta)
	position += rn_vel * delta
	
	var margin = 200
	if position.x < margin or position.x > screen_size.x - margin:
		target_vel.x *= -1
		rn_vel.x *= -1
	if position.y < margin or position.y > screen_size.y - margin:
		target_vel.y *= -1
		rn_vel.y *= -1
	
func _change_dir() -> void:
	var angle = randf_range(0, TAU)
	target_vel = Vector2.RIGHT.rotated(angle) * max_vel

func die() -> void:
	dead = true
	target_vel = Vector2.ZERO
	rn_vel = Vector2.ZERO
	sprite.texture = preload("res://sprites/mosquitoD.png")
	


func _on_change_dir_timer_timeout() -> void:
	if !dead:
		_change_dir()
