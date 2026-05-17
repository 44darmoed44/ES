@tool
class_name WeaponBase
extends Node2D


@export var center_distance: float

@export_tool_button("upd center dist", "Callable") 
var upd_dist_btn = update_center_distance
func update_center_distance():
	animator.position.x = center_distance

@export var need_animator: bool = true
@export var animator: AnimatedSprite2D
@export var timer: Timer 
@export var need_attack_zone: bool
@export var attack_zone: Area2D
@export var attack_time: float
@export var level: int
@export var hit_damage: int

@export var entered_enemies: Array


func _ready() -> void:
	if need_animator:
		animator.connect("animation_finished", _on_animation_finished)
	if need_attack_zone:
		attack_zone.set_collision_mask_value(2, true)
		attack_zone.connect("body_entered", _on_body_entered)
		attack_zone.connect("body_exited", _on_body_exited)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = attack_time
	timer.one_shot = true
	timer.start()
	

func _process(delta: float) -> void:
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
