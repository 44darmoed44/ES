@tool
extends WeaponBase

signal upgrade_level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_level.connect(_on_upgrade_level)
	emit_signal("upgrade_level")
	super()


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.sword_prop["max_level"]:
		return
	if level < WeaponsProperties.sword_prop["max_level"]-1:
		attack_time = WeaponsProperties.sword_prop[level]["as"]
		hit_damage = WeaponsProperties.sword_prop[level]["dmg"]
	if level == WeaponsProperties.sword_prop["max_level"]:
		var sword = WeaponsProperties.weapons["sword"].instantiate()
		get_parent().add_child(sword)
		sword.scale.x = -1
		
