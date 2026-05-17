extends Node2D

@export var wlist = []

func _ready() -> void:
	update_weapon_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# self.look_at(get_global_mouse_position())
	for child in get_children():
		if child is Sword:
			child.look_at(get_global_mouse_position())
			child.rotation_degrees += 45 * child.num
		if child is Bow:
			child.rotation += 1 * delta


func update_weapon_list():
	wlist.clear()
	for child in get_children():
		wlist.append(child)


func update_bows():
	var bows: Array
	var num = WeaponsProperties.bows_count
	var angle_dist = 360.0 / num
	for el in get_children():
		if el is Bow:
			bows.append(el)
	for i in range(num):
		bows[i].rotation_degrees = 0 + i*angle_dist
