extends Node2D

@export var player: Player
@export var spawn_time: int

@onready var enemy_inst = preload("res://Characters/Enemy/Soldier/Soldier.tscn")
@onready var timer := $Timer

func _ready() -> void:
	timer.connect("timeout", _on_timeout)
	timer.wait_time = spawn_time

func spawn_enemy_on_edge() -> Vector2:
	var player_pos = player.global_position
	var viewport_size = get_viewport().get_visible_rect().size
	var camera = player.get_node("Camera2D")
	
	# Определяем границы видимости
	var left = player_pos.x - viewport_size.x / 2
	var right = player_pos.x + viewport_size.x / 2
	var top = player_pos.y - viewport_size.y / 2
	var bottom = player_pos.y + viewport_size.y / 2
	
	# Выбираем случайную сторону
	var side = randi() % 4
	var spawn_pos = Vector2()
	var offset = 50  # Отступ от края
	
	match side:
		0:  # Сверху
			spawn_pos = Vector2(
			randf_range(left, right),
			top - offset
			)
		1:  # Снизу
			spawn_pos = Vector2(
			randf_range(left, right),
			bottom + offset
			)
		2:  # Слева
			spawn_pos = Vector2(
			left - offset,
			randf_range(top, bottom)
			)
		3:  # Справа
			spawn_pos = Vector2(
			right + offset,
			randf_range(top, bottom)
			)
	return spawn_pos

func _on_timeout() -> void:
	var enemy = enemy_inst.instantiate()
	add_child(enemy)
	enemy.global_position = spawn_enemy_on_edge()
