extends Node2D
@export var threshold_x: float = 945.0

# A flag to ensure we only transition once.
var transitioned: bool = false
var next_scene = preload("res://levels/level_1.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ani = $AnimationPlayer
	ani.current_animation = "tutorial_bg"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = $Player 
	var wall = $Wall
	#if wall.status == 0:
		#print("try running around the couch")
	#if wall.status == 1:
		#print("try hitting it with your cane (press space!)")
	#if wall.status == 3:
	if player.global_position.x > threshold_x:
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
