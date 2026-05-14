extends Panel

signal show()

@export var weapons: Node2D
@onready var animator := $AnimationPlayer

var wlist = []

func _ready() -> void:
	show.connect(_on_show)
	wlist = weapons.wlist
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_show() -> void:
	animator.play("show")
	get_tree().paused = true


func _on_sword_btn_pressed() -> void:
	animator.play("hide")
	for w in wlist:
		if w is Sword:
			w.emit_signal("upgrade_level")
	get_tree().paused = false
	weapons.update_weapon_list()
