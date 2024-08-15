extends Area2D

@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

var death_count: int = 0

func _on_body_entered(body):
	print("You died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
