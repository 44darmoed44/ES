class_name XPOrbs
extends CharacterBody2D

@export var xp: int
@export var color_variations: Dictionary[int, Color]

@onready var texture := $Sprite2D

func _ready() -> void:
	texture.modulate = color_variations[xp]
