extends Panel

signal show()

@export var weapons: Node2D
@onready var container := $VBoxContainer
@onready var animator := $AnimationPlayer
@onready var btn_base_inst = preload("res://Scens/UI/Shop/BaseBTN.tscn") 

var wlist = []
var wandi = ["sword", "bow", "bomb", "musket"]

var is_hidden = true

func _ready() -> void:
	show.connect(_on_show)
	wlist = weapons.wlist
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_show() -> void:
	check_wandi()
	print(wandi)
	print(is_hidden, " ", wandi.is_empty())
	if is_hidden and not wandi.is_empty():
		is_hidden = false
		wandi.shuffle()
		var rng = 3 if len(wandi) >= 3 else len(wandi)
		for i in range(rng):
			var new_btn = btn_base_inst.instantiate()
			new_btn.parent = self
			new_btn.key = wandi[i]
			new_btn.btn_type = "weapon"
			new_btn.wlist = weapons.wlist
			container.add_child(new_btn)
		animator.play("show")
		get_tree().paused = true


func check_wandi() -> void:
	var lvl_list = PlayerProperties.weapons
	var max_lvl = WeaponsProperties.max_levels
	for el in wandi:
		if lvl_list[el] == max_lvl[el]:
			wandi.erase(el)



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hide":
		is_hidden = true
		for child in container.get_children():
			child.queue_free()
