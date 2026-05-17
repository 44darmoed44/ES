@tool
class_name Sword
extends WeaponBase

signal upgrade_level

var num = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		upgrade_level.connect(_on_upgrade_level)
		emit_signal("upgrade_level")
		super()


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.sword_prop["max_level"]:
		return
	attack_time = WeaponsProperties.sword_prop[level]["as"]
	hit_damage = WeaponsProperties.sword_prop[level]["dmg"]

	timer.wait_time = attack_time

	if level == WeaponsProperties.sword_prop["max_level"] and \
		WeaponsProperties.swords_count < 8:
		var sword = WeaponsProperties.weapons["sword"].instantiate()
		sword.num = WeaponsProperties.swords_count
		WeaponsProperties.swords_count += 1
		PlayerProperties.weapons["sword"] += 1
		get_parent().add_child(sword)
		sword.rotation_degrees = self.rotation_degrees + 45
		
