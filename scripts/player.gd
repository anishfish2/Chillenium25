extends CharacterBody2D

const speed = 150.0
const plane_scene = preload("res://scenes/plane.tscn")
var plane_out = false
@export var arrow_spawn_distance: float = 300.0  # Maximum distance at which a wall can be targeted

var allWallsStatus3 = true

func _process(delta: float) -> void:

	# Iterate through all nodes in the "walls" group.
	for wall in get_tree().get_nodes_in_group("wall"):
		# Directly check the status property.
		if wall.status != 3:
			allWallsStatus3 = false
			break

func _physics_process(delta: float) -> void:
	# Handle movement input.
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if !plane_out and Input.is_action_just_pressed("ui_plane"):
		plane_out = true
		var plane = plane_scene.instantiate()
		get_parent().add_child(plane)
		plane.position = self.position
	
	
	velocity = input_vector * speed
	if !plane_out:
		move_and_slide()
	# Check if the player is moving.
	if input_vector != Vector2.ZERO:

		var angle_deg = rad_to_deg(input_vector.angle())
		var animation_name = ""
		
		# Determine the appropriate animation based on 45° sectors.
		if angle_deg >= -22.5 and angle_deg < 22.5:
			animation_name = "right_walk"
			$forward.visible = false
			$backward.visible = false
			$left.visible = false
			$right.visible = true
		elif angle_deg >= 22.5 and angle_deg < 67.5:
			animation_name = "foward_walk"
			$forward.visible = true
			$backward.visible = false
			$left.visible = false
			$right.visible = false
		elif angle_deg >= 67.5 and angle_deg < 112.5:
			animation_name = "foward_walk"
			$forward.visible = true
			$backward.visible = false
			$left.visible = false
			$right.visible = false
		elif angle_deg >= 112.5 and angle_deg < 157.5:
			animation_name = "foward_walk"
			$forward.visible = true
			$backward.visible = false
			$left.visible = false
			$right.visible = false
		# For angles around 180/-180, we combine two ranges.
		elif angle_deg >= 157.5 or angle_deg < -157.5:
			animation_name = "left_walk"
			$forward.visible = false
			$backward.visible = false
			$left.visible = true
			$right.visible = false
		elif angle_deg >= -157.5 and angle_deg < -112.5:
			animation_name = "backward_walk"
			$forward.visible = false
			$backward.visible = true
			$left.visible = false
			$right.visible = false
		elif angle_deg >= -112.5 and angle_deg < -67.5:
			animation_name = "backward_walk"
			$forward.visible = false
			$backward.visible = true
			$left.visible = false
			$right.visible = false
		elif angle_deg >= -67.5 and angle_deg < -22.5:
			animation_name = "backward_walk"
			$forward.visible = false
			$backward.visible = true
			$left.visible = false
			$right.visible = false
		# Play the determined animation.
		$AnimationPlayer.play(animation_name)

		
	# Process collisions (if you need to interact with walls on collision)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.has_method("on_player_collide"):
			collider.on_player_collide(collision.get_position(), collision.get_normal())
