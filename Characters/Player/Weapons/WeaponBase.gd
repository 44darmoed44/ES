class_name WeaponBase
extends Node2D

@export var animator: AnimatedSprite2D
@export var timer: Timer
@export var attack_time: float
@export var attack_zone: Area2D
@export var level: int
@export var hit_damage: int
@export var upgrades_sprite: Dictionary[int, SpriteFrames]

var entered_enemies: Array


func _ready() -> void:
	attack_zone.set_collision_mask_value(2, true)
	animator.sprite_frames = upgrades_sprite[1]
	animator.connect("animation_finished", _on_animation_finished)
	attack_zone.connect("body_entered", _on_body_entered)
	attack_zone.connect("body_exited", _on_body_exited)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = attack_time
	timer.one_shot = true
	timer.start()
	

func _process(delta: float) -> void:
	self.look_at(get_global_mouse_position())
	if get_global_mouse_position().x > global_position.x:
		scale.y = 1
	if get_global_mouse_position().x < global_position.x:
		scale.y = -1   


func deal_damage() -> void:
	for enemy in entered_enemies:
		enemy.emit_signal("get_damage", hit_damage)
		

func _on_timer_timeout():
	animator.play()
	deal_damage()


func _on_animation_finished():
	timer.start()


func _on_body_entered(body) -> void:
	if body.is_in_group("enemy"):
		entered_enemies.append(body)


func _on_body_exited(body) -> void:
	if body.is_in_group("enemy"):
		entered_enemies.erase(body)
