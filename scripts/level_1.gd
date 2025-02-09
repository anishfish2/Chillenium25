extends Node2D
@export var threshold_x: float = 1170.0

# A flag to ensure we only transition once.
var transitioned: bool = false
var next_scene = preload("res://levels/tutorial2.tscn").instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = $Player 
	if not transitioned and player.global_position.x > threshold_x:
		transitioned = true  
		get_node("/root/WinSound").play()
		get_tree().change_scene_to_file("res://levels/tutorial2.tscn")
		
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()
