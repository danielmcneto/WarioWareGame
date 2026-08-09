extends HSlider

var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Master")
	
	value_changed.connect(_on_value_changed)
	
	var volume_rn = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(volume_rn)


func _on_value_changed(value: float) -> void:
	var volume = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, volume)
