extends Node2D

var speed = 300
var dmg = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Vector2.RIGHT.rotated(rotation)
	position += dir * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_hit_collider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.emit_signal("get_damage", dmg)
		queue_free()
