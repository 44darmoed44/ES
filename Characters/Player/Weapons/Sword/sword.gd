@tool
class_name Sword
extends WeaponBase

signal upgrade_level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_level.connect(_on_upgrade_level)
	emit_signal("upgrade_level")
	super()


func _on_upgrade_level() -> void:
	print(level)
	print(123)
	level += 1
	if level > WeaponsProperties.sword_prop["max_level"]:
		return
	if level < WeaponsProperties.sword_prop["max_level"]-1:
		attack_time = WeaponsProperties.sword_prop[level]["as"]
		hit_damage = WeaponsProperties.sword_prop[level]["dmg"]
	if level == WeaponsProperties.sword_prop["max_level"] and \
		WeaponsProperties.swords_count < 8:
		var sword = WeaponsProperties.weapons["sword"].instantiate()
		get_parent().add_child(sword)
		sword.rotation_degrees = self.rotation_degrees + 45
		print(sword.rotation_degrees)
		WeaponsProperties.swords_count += 1
		
