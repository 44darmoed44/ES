@tool
class_name Bow
extends WeaponBase

@onready var arrow_inst = preload("res://Characters/Player/Weapons/Bow/arrow.tscn")
@onready var bow_isnt = preload("res://Characters/Player/Weapons/Bow/bow.tscn")

signal upgrade_level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		if not Engine.is_editor_hint():
			upgrade_level.connect(_on_upgrade_level)
			emit_signal("upgrade_level")
			super()


func _on_animation_finished() -> void:
	if animator.animation == "shoot":
		for i in range(level):
			var arrow = arrow_inst.instantiate()
			get_tree().current_scene.add_child(arrow)
			arrow.position = animator.global_position
			var t = i / float(level - 1) if level > 1 else 0.5
			arrow.rotation = animator.global_rotation + deg_to_rad(20) * (t - 0.5)
			arrow.dmg = hit_damage
		timer.start()


func _on_timer_timeout():
	animator.play("shoot")


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.bow_prop["max_level"]:
		return
	attack_time = WeaponsProperties.bow_prop[level]["as"]
	hit_damage = WeaponsProperties.bow_prop[level]["dmg"]

	timer.wait_time = attack_time

	if level == WeaponsProperties.bow_prop["max_level"] and \
		WeaponsProperties.bows_count < 3:
			var bow = bow_isnt.instantiate()
			WeaponsProperties.bows_count += 1
			get_parent().add_child(bow)
