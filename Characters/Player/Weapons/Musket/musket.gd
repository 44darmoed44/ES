@tool
class_name  Musket
extends WeaponBase

signal upgrade_level

@onready var bullet_inst = preload("res://Characters/Player/Weapons/Musket/bullet.tscn")
@onready var bullet_target_inst = preload("res://Characters/Player/Weapons/Musket/bullet_target.tscn")
@onready var bullet_start_pos = $AnimatedSprite2D/StartBulletPos

var bullet_end_pos: Vector2

var bullet_dmg: int
var shrapnel_num: int

var can_shoot := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		upgrade_level.connect(_on_upgrade_level)
		emit_signal("upgrade_level")
		super()
		timer.stop()


func _on_timer_timeout():
	print("can shoot")
	can_shoot = true


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
			can_shoot = false
			bullet_end_pos = get_global_mouse_position()
			var bullet_target = bullet_target_inst.instantiate()
			get_tree().current_scene.call_deferred("add_child", bullet_target)
			bullet_target.global_position = bullet_end_pos
			animator.play("shoot")


func _on_upgrade_level() -> void:
	level += 1
	if level > WeaponsProperties.musket_prop["max_level"]:
		return
	attack_time = WeaponsProperties.musket_prop[level]["cd"]
	hit_damage = WeaponsProperties.musket_prop[level]["shrp_dmg"]
	bullet_dmg = WeaponsProperties.musket_prop[level]["bll_dmg"]
	shrapnel_num = WeaponsProperties.musket_prop[level]["shrpn_num"]

	timer.wait_time = attack_time


func _on_animation_finished():
	if animator.animation == "shoot":

		var bullet = bullet_inst.instantiate()
		bullet.is_shrapnel = true
		bullet.start_pos = bullet_start_pos.global_position
		bullet.end_pos = bullet_end_pos
		
		bullet.bullet_dmg = bullet_dmg
		bullet.shrapnel_num = shrapnel_num
		bullet.shrapnel_dmg = hit_damage
		
		get_tree().current_scene.add_child(bullet)

		animator.play("idle")
		timer.start()
