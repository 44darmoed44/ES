extends Node2D

@export var wlist = []

func _ready() -> void:
	update_weapon_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.look_at(get_global_mouse_position())
	# for child in get_children():
	# 	if child is Sword:
	# 		child.look_at(get_global_mouse_position())


func update_weapon_list():
	for child in get_children():
		wlist.append(child)