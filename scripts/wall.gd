# Wall.gd
extends StaticBody2D

signal flash_triggered(target_offset: float, flash_duration: float)

@onready var collision_shape: CollisionPolygon2D = $CollisionPolygon2D
@onready var wall_sprite: AnimatedSprite2D = $"AnimatedSprite2D"

@export var arrow_spawn_distance: float = 300.0
@export var flash_duration: float = 1.0
@export var left_col: float = 1.0
@export var right_col: float = 1.0
@export var bottom_row: float = 1.0
@export var top_row: float = 1.0
@export var status = 0
@export var left_status = 0
@export var right_status = 0
@export var bottom_status = 0
@export var top_status = 0

var is_touching: bool = false
var current_flash_tween: Tween = null
var can_register_hit: bool = true

func on_player_collide(collision_point: Vector2, collision_normal: Vector2) -> void:
	if not can_register_hit:
		return  # Exit if we're still in cooldown.
	can_register_hit = false
	var direction = get_relative_direction(collision_point)
	flash_wall()
	$CooldownTimer.start()
	print('sendign signal')
	emit_signal("flash_triggered", 200.0, flash_duration, left_col, right_col, bottom_row, top_row, direction)

func _process(delta: float) -> void:
	$AnimatedSprite2D.frame = status
	if is_touching and Input.is_action_just_pressed("ui_select"):
		status += 1
	
	if is_touching:
		
		var sprite = get_node('/root/Node2D/Player/forward')

		var min_player_y = sprite.global_position.y 
		var min_wall_y = get_min_player_y($AnimatedSprite2D)

		if min_wall_y != null:
			if min_player_y <= min_wall_y:
				self.z_index = 10
			else:
				self.z_index = 3
				
		if right_status + left_status + bottom_status + top_status == 4 and status < 2:
			var planes_raising = get_parent().get_node("RaisingPlanes")
			if planes_raising:
				planes_raising.filter_markers()
			print("upgraded")
			status = 1
		
func get_min_player_y(animated_sprite: AnimatedSprite2D):
	var frameIndex: int = $AnimatedSprite2D.get_frame()
	var animationName: String = $AnimatedSprite2D.animation
	var spriteFrames: SpriteFrames = $AnimatedSprite2D.get_sprite_frames()
	if frameIndex > 0:
		var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, 1)
		var min_wall_y = $AnimatedSprite2D.global_position.y - (currentTexture.get_height() * $AnimatedSprite2D.scale.y / 2)
		return min_wall_y
		
	return null
	
	
func flash_wall() -> void:
	if current_flash_tween:
		current_flash_tween.kill()
		current_flash_tween = null
	wall_sprite.modulate = Color(1, 1, 1, 1)
	current_flash_tween = create_tween()
	current_flash_tween.tween_property(wall_sprite, "modulate", Color(1, 1, 1, 1), flash_duration) \
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func _ready() -> void:
	add_to_group("walls")


func get_relative_direction(point: Vector2) -> int:
	# Calculate vector from the wall center to the collision point.
	var diff: Vector2 = point - global_position
	# Compute the angle (in degrees) of the diff vector.
	var angle_deg: float = rad_to_deg(atan2(diff.y, diff.x))
	if angle_deg < 0:
		angle_deg += 360  # Normalize angle to the range [0, 360)
	
	# Check each region based on the boundary angles:
	# Region for "Right" (classification 2): between (8,2) and (6,-6).
	# That is: angle >= 315° or angle < 14.036°.
	if angle_deg >= 315 or angle_deg < 14.036:
		top_status = 1
		return 4
		
	# Region for "Top" (classification 4): between (8,2) and (-6,6) i.e., 14.036° to 135°.
	elif angle_deg >= 14.036 and angle_deg < 135:
		right_status = 1
		return 2
	# Region for "Left" (classification 1): between (-6,6) and (-8,-1) i.e., 135° to 187.125°.
	elif angle_deg >= 135 and angle_deg < 187.125:
		bottom_status = 1
		return 3
	# Region for "Bottom" (classification 3): between (-8,-1) and (6,-6) i.e., 187.125° to 315°.
	elif angle_deg >= 187.125 and angle_deg < 315:
		left_status = 1
		return 1
	return	 0  # Fallback (should not be reached if all cases are covered).


func _on_cooldown_timer_timeout() -> void:
	can_register_hit = true   
	$CooldownTimer.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PLANEcollision":
		status = 3

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.name == 'player_cane':
		is_touching = true
	
func _on_cane_range_area_exited(area: Area2D) -> void:
	is_touching = false # Replace with function body.
