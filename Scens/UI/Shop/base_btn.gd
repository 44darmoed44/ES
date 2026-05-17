class_name UIBTNBase
extends MarginContainer

@onready var btn = $Button

var parent: Control
var key: String
var btn_type: String
var wlist: Array

var funcs = {
	"weapon" : w_update
}

var in_list = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(250, 350)
	wlist = parent.wlist
	btn.text = UiData.weapons[key]["description"]
	match btn_type:
		"weapon":
			var wtypes = WeaponsProperties.wtypes
			for w in wlist:
				if w.get_script() == wtypes[key]:
					in_list = true
					break
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_button_pressed() -> void:
	funcs[btn_type].call()
	parent.animator.play("hide")
	get_tree().paused = false


func w_update() -> void:
	print(in_list)
	if in_list: 
		var wtypes = WeaponsProperties.wtypes
		for w in wlist:
			if w.get_script() == wtypes[key]:
				w.emit_signal("upgrade_level")
	else:
		var w = WeaponsProperties.weapons[key].instantiate()
		parent.weapons.add_child(w)
	parent.weapons.update_weapon_list()
	if key == "sword" and WeaponsProperties.swords_count == 0:
		WeaponsProperties.swords_count += 1
		PlayerProperties.weapons[key] += 1
	if key == "bow":
		if WeaponsProperties.bows_count == 0:
			WeaponsProperties.bows_count += 1
		parent.weapons.update_bows()
