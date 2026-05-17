class_name Bullet
extends Node2D

@onready var bullet_inst = preload("res://Characters/Player/Weapons/Musket/bullet.tscn")
@onready var sprite = $Sprite2D

var bullet_dmg: int
var shrapnel_num = 1
var shrapnel_dmg: int

var start_pos: Vector2
var end_pos: Vector2
var t: float = 0.0
var duration: float = 1.0
var height: float = 100.0

var is_shrapnel = false

var speed = 300

func _ready() -> void:
	if is_shrapnel:
		$Sprite2D.scale = Vector2(7, 7)


func _process(delta) -> void:
	sprite.rotation += 10 * delta
	if is_shrapnel:    
		if t < 1.0:
			t += delta / duration
			var horizontal = start_pos.lerp(end_pos, t)
			var vertical = -sin(t * PI) * height
			position = horizontal + Vector2(0, vertical)
		else:
			create_bullets()
			queue_free()
	else:
		var dir = Vector2.RIGHT.rotated(rotation)
		position += dir * speed * delta


func create_bullets() -> void:
	var angle_dist = 360.0/shrapnel_num
	for i in range(shrapnel_num):
		var bullet = bullet_inst.instantiate()
		get_tree().current_scene.call_deferred("add_child", bullet)
		bullet.bullet_dmg = bullet_dmg
		bullet.rotation = deg_to_rad(0 + i * angle_dist)
		bullet.position = Vector2(position.x + 25, position.y)


func _on_hit_collider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var current_dmg = bullet_dmg
		if is_shrapnel:
			create_bullets()
			current_dmg = shrapnel_dmg
		body.emit_signal("get_damage", current_dmg)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
