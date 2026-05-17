class_name BombPrefab
extends Node2D

signal blow_up

@onready var animator := $AnimatedSprite2D

@export var end_pos: Vector2
@export var start_pos: Vector2

var speed = 300.0
var dir: Vector2
var is_moving := true
var dmg: int

var enemy_list: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blow_up.connect(_on_blow_up)
	dir = (end_pos - start_pos).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		position += dir * speed * delta


func _on_attack_collider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_list.append(body)


func _on_bomb_collider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		is_moving = false
		animator.play("blow_up")


func _on_attack_collider_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_list.erase(body)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animator.animation == "blow_up":
		for en in enemy_list:
			en.emit_signal("get_damage", dmg)
		queue_free()


func _on_blow_up() -> void:
	is_moving = false
	animator.play("blow_up")