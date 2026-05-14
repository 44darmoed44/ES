extends Node2D

@export var wlist = []

func _ready() -> void:
	for child in get_children():
		wlist.append(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.look_at(get_global_mouse_position())