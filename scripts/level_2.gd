extends Node2D
@export var threshold_x: float = 1000.0
@export var threshold_y: float = 350.0

# A flag to ensure we only transition once.
var transitioned: bool = false
var next_scene = preload("res://levels/level_3.tscn").instantiate()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = $Player 
	
	if player.global_position.x > threshold_x and player.global_position.y > threshold_y:
		get_node("/root/WinSound").play()
		get_tree().change_scene_to_file("res://levels/tutorial3.tscn")
	
	if Input.is_action_just_pressed("ui_restart"):
		get_node("/root/Restart").play()
		get_tree().reload_current_scene()
