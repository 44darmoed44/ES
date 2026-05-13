extends Node2D

@export var chunk_scene: PackedScene  # Сцена Chunk.tscn
@export var chunk_size: float = 512   # Размер чанка в пикселях
@export var render_distance: int = 2  # Сколько чанков подгружать
@export var player: CharacterBody2D

@onready var chunk_container: Node2D = $ChunkContainer
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

# Словарь загруженных чанков: ключ = Vector2i (координаты чанка)
var loaded_chunks = {}

func _ready():
	# Подключаем сигнал
	screen_notifier.connect("screen_exited", _on_screen_exited)
	# Начальная генерация
	update_chunks()

func _on_screen_exited():
	print("chunks loaded")
	# Когда экран ушел от уведомителя - обновляем чанки
	update_chunks()
	# Возвращаем уведомитель к игроку
	screen_notifier.global_position = player.global_position

func update_chunks():
	# Получаем координаты чанка, в котором находится игрок
	var player_chunk = world_to_chunk_coords(player.global_position)
	
	# Проходим по области видимости
	for x in range(player_chunk.x - render_distance, player_chunk.x + render_distance + 1):
		for y in range(player_chunk.y - render_distance, player_chunk.y + render_distance + 1):
			var chunk_key = Vector2i(x, y)
			if not loaded_chunks.has(chunk_key):
				load_chunk(chunk_key)
	
	# Удаляем дальние чанки
	unload_far_chunks(player_chunk)

func world_to_chunk_coords(world_pos: Vector2) -> Vector2i:
	# Переводим мировые координаты в координаты чанка
	var chunk_x = floor(world_pos.x / chunk_size)
	var chunk_y = floor(world_pos.y / chunk_size)
	return Vector2i(chunk_x, chunk_y)

func load_chunk(chunk_coords: Vector2i):
	# Создаем экземпляр чанка
	var chunk = chunk_scene.instantiate()
	chunk_container.add_child(chunk)
	
	# Позиционируем чанк
	chunk.position = Vector2(
		chunk_coords.x * chunk_size,
		chunk_coords.y * chunk_size
	)
	
	# Сохраняем в словаре
	loaded_chunks[chunk_coords] = chunk

func unload_far_chunks(player_chunk: Vector2i):
	var chunks_to_remove = []
	
	for chunk_key in loaded_chunks.keys():
		# Если чанк слишком далеко по X или Y
		if abs(chunk_key.x - player_chunk.x) > render_distance + 1 or \
		   abs(chunk_key.y - player_chunk.y) > render_distance + 1:
			chunks_to_remove.append(chunk_key)
	
	# Удаляем найденные чанки
	for chunk_key in chunks_to_remove:
		loaded_chunks[chunk_key].queue_free()
		loaded_chunks.erase(chunk_key)
