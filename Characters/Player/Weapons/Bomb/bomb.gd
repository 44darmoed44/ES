@tool
class_name Bomb
extends WeaponBase

signal upgrade_level

@onready var bomb_prefab = preload("res://Characters/Player/Weapons/Bomb/bomb_prefab.tscn")


var num: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		upgrade_level.connect(_on_upgrade_level)
		emit_signal("upgrade_level")
		super()

func _on_timer_timeout() -> void:
	for i in range(num):
		if entered_enemies.is_empty():
			continue
		var bomb = bomb_prefab.instantiate()
		var enemy = entered_enemies.pick_random()
		if enemy == null: break
		var new_end_pos = enemy.global_position
		bomb.end_pos = new_end_pos
		bomb.start_pos = global_position
		bomb.global_position = global_position
		bomb.dmg = hit_damage
		get_tree().current_scene.add_child(bomb)
		await get_tree().create_timer(.5).timeout
	timer.start()


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.bomb_prop["max_level"]:
		return
	attack_time = WeaponsProperties.bomb_prop[level]["as"]
	hit_damage = WeaponsProperties.bomb_prop[level]["dmg"]
	num = WeaponsProperties.bomb_prop[level]["num"]

	timer.wait_time = attack_time


func _on_attack_zone_area_exited(area: Area2D) -> void:
	var entity = area.get_parent() 
	if entity is BombPrefab and  entity.is_moving:
		entity.emit_signal("blow_up")
