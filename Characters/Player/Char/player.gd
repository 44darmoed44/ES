extends CharacterBody2D
class_name Player

signal get_damage(damage: float)

@onready var animator := $AnimatedSprite2D
@onready var hp_bar := $HPBar
@onready var xp_bar = $CanvasLayer/XPBar
@onready var lvl_text := $CanvasLayer/Label
@onready var wi_screen := $CanvasLayer/WIScreen

enum Direction {
	WALK,
	WALKBACK,
	WALKBACKSIDE,
	WALKFRONT,
	WALKFRONTSIDE
}

var current_dir: Direction = Direction.WALKFRONT

var hp: int
var is_damage = false

var prop := PlayerProperties

func _ready() -> void:
	hp = prop.max_hp 
	hp_bar.max_value = hp
	xp_bar.max_value = prop.xp_next_lvl


func _physics_process(delta: float) -> void:
	hp_bar.value = hp
	xp_bar.value = prop.current_xp
	lvl_text.text = "Level: " + str(prop.player_lvl) + "\n" + str(prop.current_xp) + "/" + str(prop.xp_next_lvl)
	_movement_controller()
	_update_animation()
	move_and_slide()


func _movement_controller():
	var input_dir := Input.get_vector("left", "right", "up", "down").normalized()
	var dir = input_dir * prop.speed
	
	if dir:
		velocity = dir
		if velocity.x != 0 and velocity.y > 0:
			current_dir = Direction.WALKFRONTSIDE
		elif velocity.x != 0 and velocity.y < 0:
			current_dir = Direction.WALKBACKSIDE
		elif velocity.y < 0:
			current_dir = Direction.WALKBACK
		elif velocity.y > 0:
			current_dir = Direction.WALKFRONT
		else:
			current_dir = Direction.WALK
	else:
		velocity = Vector2.ZERO	


func _update_animation():
	if velocity.x < 0:
		animator.flip_h = true
	if velocity.x > 0:
		animator.flip_h = false

	if velocity.length() != 0:
		match current_dir:
			Direction.WALK:
				animator.play("Walk")
			Direction.WALKBACK:
				animator.play("WalkBack")
			Direction.WALKBACKSIDE:
				animator.play("WalkBackSide")
			Direction.WALKFRONT:
				animator.play("WalkFront")
			Direction.WALKFRONTSIDE:
				animator.play("WalkFrontSide")
	else:
		match current_dir:
			Direction.WALK:
				animator.play("IdleStand")
			Direction.WALKBACK:
				animator.play("IdleStandBack")
			Direction.WALKBACKSIDE:
				animator.play("IdleStandBackSide")
			Direction.WALKFRONT:
				animator.play("IdleStandFront")
			Direction.WALKFRONTSIDE:
				animator.play("IdleStandSide")


func _on_get_damage(damage: float) -> void:
	if not is_damage:
		animator.modulate = "#f70000"
		is_damage = true
		await get_tree().create_timer(.25).timeout
		animator.modulate = "#ffffff"
		is_damage = false
		hp -= damage
		if hp <= 0:
			get_tree().quit()


func _on_xp_orb_collector_body_entered(body: Node2D) -> void:
	if body is XPOrbs:
		_check_level(body.xp)
		body.queue_free()


func _check_level(xp: int) -> void:
	prop.current_xp += xp
	while prop.current_xp >= prop.xp_next_lvl:
		prop.current_xp -= prop.xp_next_lvl
		prop.player_lvl += 1
		prop.xp_next_lvl += 2 * prop.next_lvl_xp_mult
		xp_bar.max_value = prop.xp_next_lvl
		wi_screen.emit_signal("show")



func _on_button_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	else:
		get_tree().paused = true
