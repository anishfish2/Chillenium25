extends Node2D

var angle = 0
const angle_velocity = 3
const velocity = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$Go.play()
	$Done.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		angle -= angle_velocity * delta
	if Input.is_action_pressed("ui_right"):
		angle += angle_velocity * delta
	
	position.x += cos(angle) * velocity
	position.y += sin(angle) * velocity
	
	$Sprite2D.rotation = angle
	
	


func _on_timer_timeout() -> void:
	get_parent().get_node("Player").plane_out = false
	$Done.play()
	$Done.reparent(get_parent())
	queue_free()
