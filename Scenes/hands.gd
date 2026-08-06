extends Node2D
@onready var left: Node2D = $left
@onready var right: Node2D = $right
@onready var smack_zone: Area2D = $zone

@onready var themed_timer: Node2D = $"../ThemedTimer"
@onready var hit_effect: Sprite2D = $"../hitEffect"

var hited = false
var timer_end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await themed_timer.Timer(5.0)
	#after this is completed...
	timer_end = true 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		hit_effect.position.y = smack_zone.global_position.y
		_smack()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_y = get_global_mouse_position().y
	position.y = mouse_y + 500	
	
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -=1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

func _check_hit() -> void:
	var mosquitos = smack_zone.get_overlapping_areas()
	
	if mosquitos.size() > 0:
		for x in mosquitos:
			x.die()
			hited = true
	
func _check_win() -> void:
	if hited:
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
	
func _smack() -> void:
	var tween = get_tree().create_tween()
	
	#close hand
	tween.tween_property(left, "global_position:x", 480.0, 0.06)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(right, "global_position:x", 718.0, 0.06)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(func(): hit_effect.visible = true)
	tween.tween_callback(_check_hit)
	# open hand
	tween.tween_property(left, "position:x", 145.0, 0.2)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(right, "position:x", 1026.0, 0.2)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.1)
	tween.tween_callback(func(): hit_effect.visible = false)
	tween.tween_interval(0.4)
	tween.tween_callback(_check_win)
	
	
