@icon("res://Resourcers/EnemyBaseIcon.svg")

## Enemy base node. Have movement_controller, info about player
class_name EnemyBase
extends CharacterBody2D

signal get_damage(damage: float) 

@export var player: Player 
@export var orientation_node: Node2D
@export var attack_hitbox: Area2D
@export var animator: AnimatedSprite2D
@export var can_move := true
@export var is_damage := false
@export var is_attacking := false 
@export var hp = 10

@onready var xp_orb = preload("res://Characters/XPOrbs/xp_orb.tscn").instantiate()

var speed = 100

func _ready() -> void:
	collision_layer = 2
	motion_mode = MOTION_MODE_FLOATING
	player = get_tree().get_first_node_in_group("player")
	connect("get_damage", _on_get_damage)
	animator.connect("animation_finished", _on_animation_finished)
	attack_hitbox.connect("body_entered", _on_body_entered)
	attack_hitbox.connect("body_exited", _on_body_exited)


func _process(delta: float) -> void:
	if not is_attacking and not is_damage:
		if can_move:
			movement_controller(delta)
		update_animation()
	move_and_slide()


func movement_controller(delta: float) -> void:
	var pl_pos = player.global_position
	var dir = Vector2(pl_pos.x - global_position.x, pl_pos.y - global_position.y).normalized()
	velocity = dir * speed


func _on_get_damage(damage: float) -> void:
	velocity = Vector2.ZERO
	is_damage = true
	animator.play("get_damage")
	hp -= damage
	if hp <= 0:
		var a = randi_range(1, 100)
		var spawn = false
		if a <= 65: 
			spawn = true
			xp_orb.xp = 2
		elif a <= 85 and PlayerProperties.player_lvl >= 10: 
			spawn = true
			xp_orb.xp = 5
		elif a > 85 and PlayerProperties.player_lvl >= 20: 
			spawn = true
			xp_orb.xp = 10
		if spawn:
			xp_orb.global_position = global_position
			get_tree().current_scene.add_child(xp_orb)
		queue_free()


func update_animation() -> void:
	if player.global_position.x > global_position.x:
		orientation_node.scale.x = 1
	if player.global_position.x < global_position.x:
		orientation_node.scale.x = -1
	if velocity.length() != 0:
		animator.play("walk")
	if velocity.length() == 0:
		animator.play("idle")


func _on_animation_finished() -> void:
	if animator.animation == "get_damage":
		is_damage = false
	if animator.animation == "attack":
		await get_tree().create_timer(1).timeout
		if is_attacking: 
			animator.play("attack")
			await get_tree().create_timer(.25).timeout 
			player.emit_signal("get_damage", 2)
		

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		velocity = Vector2.ZERO
		is_attacking = true
		animator.play("attack")
		await get_tree().create_timer(.25).timeout 
		player.emit_signal("get_damage", 2)


func _on_body_exited(body) -> void:
	if body.is_in_group("player"):
		is_attacking = false
