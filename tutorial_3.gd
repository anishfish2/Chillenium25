extends Node2D
@export var threshold_x: float = 945.0

# A flag to ensure we only transition once.
var transitioned: bool = false
var next_scene = preload("res://levels/level_3.tscn").instantiate()


func _process(delta: float) -> void:
	var player = $Player 

	if player.global_position.x > threshold_x:
		get_node("/root/WinSound").play()
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
	
	if Input.is_action_just_pressed("ui_restart"):
		get_node("/root/Restart").play()
		get_tree().reload_current_scene()
