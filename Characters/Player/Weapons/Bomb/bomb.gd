@tool
class_name Bomb
extends WeaponBase

signal upgrade_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_level.connect(_on_upgrade_level)
	super()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.start()


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.bomb_prop["max_level"]:
		return
	if level < WeaponsProperties.bomb_prop["max_level"]-1:
		attack_time = WeaponsProperties.bomb_prop[level]["as"]
		hit_damage = WeaponsProperties.bomb_prop[level]["dmg"]