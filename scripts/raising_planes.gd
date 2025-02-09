# LineHandler.gd
extends Node2D


@export var marker_target_height: float = 100.0
@export var marker_duration: float = 5.0
@export var marker_scene: PackedScene = preload("res://scenes/line.tscn")  

func _ready() -> void:
	# Replace the path with the correct node path to your wall.
	var wall = get_node("/root/Node2D/Wall")
	wall.connect("flash_triggered", Callable(self, "_on_wall_flash_triggered"))

func _on_wall_flash_triggered(target_offset: float, flash_duration: float, left_col: float, right_col: float, top_row: float, bottom_row: float, side: float) -> void:
	var value = set_points(target_offset, flash_duration, left_col, right_col, top_row, bottom_row, side)
	var global_pointA = value[0]
	var global_pointB = value[1]
	#x_coords = value[2]
	
	var pointA = global_pointA
	var pointB = global_pointB

	for x_val in x_coords:
		# Calculate t from 0 to 1. Assumes pointB.x != pointA.x.
		var t: float = (x_val - pointA.x) / (pointB.x - pointA.x)
		t = clamp(t, 0.0, 1.0)
		# Determine the base point along the line using linear interpolation.
		var base_point: Vector2 = pointA.lerp(pointB, t)
		# Instance a MarkerLine node.
		var marker = marker_scene.instantiate()
		add_child(marker)

		marker.set_base_data(base_point, marker_target_height, marker_duration)
		# Add the marker to the scene.
		marker_lines.append(marker)

# A list of x coordinates at which to spawn markers.
var x_coords: Array = [150, 175, 200, 250, 300, 350, 400]

# Keep a reference to each marker for later filtering.
var marker_lines: Array = []

# This function shows only those markers whose base x coordinate lies within [min_x, max_x].
func filter_markers_by_x(min_x: float, max_x: float) -> void:
	for marker in marker_lines:
		if marker.base_position.x >= min_x and marker.base_position.x <= max_x:
			marker.visible = true
		else:
			marker.visible = false
			
var pointA: Vector2 = Vector2(100, 100)
var pointB: Vector2 = Vector2(100, 100)

func set_points(target_offset: float, flash_duration: float, left_col: float, right_col: float, top_row: float, bottom_row: float, side: float):
	if side == 1 or side == 2:
		if left_col == 0 or right_col == 0:
			pointB = Vector2(450, 64)
			pointA = Vector2(153, 307)
			x_coords = [152, 174.5, 197, 219.5, 242,
						 261.75, 281.5, 301.25, 321,
						 339.25, 357.5, 375.75, 394,
						 408, 422, 436, 450]
			return [pointA, pointB, x_coords]
		elif left_col == 1 or right_col == 1:
			pointB = Vector2(514, 82)
			pointA = Vector2(230, 334)
			return [pointA, pointB, x_coords]
		elif left_col == 2 or right_col == 2:
			pointB = Vector2(613, 54)
			pointA = Vector2(319, 369)
			return [pointA, pointB, x_coords]
		elif left_col == 3 or right_col == 3:
			pointB = Vector2(665, 66)
			pointA = Vector2(383, 394)
			return [pointA, pointB, x_coords]
		elif left_col == 4 or right_col == 4:
			pointB = Vector2(736, 84)
			pointA = Vector2(404, 475)
			return [pointA, pointB, x_coords]
		elif left_col == 5 or right_col == 5:
			pointB = Vector2(795, 97)
			pointA = Vector2(474, 507)
			return [pointA, pointB, x_coords]
		elif left_col == 6 or right_col == 6:
			pointB = Vector2(866, 115)
			pointA = Vector2(555, 543)
			return [pointA, pointB, x_coords]
		elif left_col == 7 or right_col == 7:
			pointB = Vector2(925, 129)
			pointA = Vector2(735, 415)
			return [pointA, pointB, x_coords]
		elif left_col == 8 or right_col == 8:
			pointB = Vector2(993, 145)
			pointA = Vector2(819, 334)
			return [pointA, pointB, x_coords]
		elif left_col == 1 or right_col == 9:
			pointB = Vector2(1018, 216)
			pointA = Vector2(887, 471)
			return [pointA, pointB, x_coords]
		elif left_col == 1 or right_col == 10:
			pointB = Vector2(1043, 229)
			pointA = Vector2(1007, 318)
			return [pointA, pointB, x_coords]
		elif left_col == 1 or right_col == 11:
			pointB = Vector2(1126, 331)
			pointA = Vector2(1099, 427)
			return [pointA, pointB, x_coords]


	if side == 3 or side == 4:
		return [pointA, pointB]
		if top_row == 0:
			pointA = Vector2(450, 300)
			pointB = Vector2(100, 300)
			return [pointA, pointB, x_coords]
		elif top_row == 1:
			pointA = Vector2(100, 300)
			pointB = Vector2(100, 300)
			return [pointA, pointB, x_coords]
			
