# LineHandler.gd
extends Node2D


@export var marker_target_height: float = 100.0
@export var marker_duration: float = 5.0
@export var marker_scene: PackedScene = preload("res://scenes/line.tscn")  

func _ready() -> void:
	# Replace the path with the correct node path to your wall.
	#var wall = get_node("/root/Node2D/Wall")
	var walls = get_tree().get_nodes_in_group("walls")
	for wall in walls:
		wall.connect("flash_triggered", Callable(self, "_on_wall_flash_triggered"))

func _on_wall_flash_triggered(target_offset: float, flash_duration: float, left_col: float, right_col: float, top_row: float, bottom_row: float, side: float) -> void:
	print(' asfasdf got here')
	var value = set_points(target_offset, flash_duration, left_col, right_col, top_row, bottom_row, side)
	var global_pointA = value[0]
	var global_pointB = value[1]
	var x_coords = value[2]
	var keep = value[3]
	
	var pointA = global_pointA
	var pointB = global_pointB
	print(pointA, " ", pointB)
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
		if x_val in keep:
			keep_lines.append(marker)
		else:
			marker_lines.append(marker)

# A list of x coordinates at which to spawn markers.
var x_coords: Array = [150, 175, 200, 250, 300, 350, 400]

# Keep a reference to each marker for later filtering.
var marker_lines: Array = []
var keep_lines: Array = []

# This function shows only those markers whose base x coordinate lies within [min_x, max_x].
func filter_markers(min_x: float, max_x: float, min_y: float, max_y: float) -> void:
	for marker in keep_lines:
		if marker.base_position.x >= min_x - 20 and marker.base_position.x <= max_x + 20 and marker.base_position.y >= min_y - 20 and marker.base_position.y <= max_y + 20:
			marker.visible = true
		else:
			marker.visible = false


var pointA: Vector2 = Vector2(100, 100)
var pointB: Vector2 = Vector2(100, 100)

func set_points(target_offset: float, flash_duration: float, left_col: float, right_col: float, top_row: float, bottom_row: float, side: float):
	print(side)
	if side == 1 or side == 2:
		var main = null
		if side == 1:
			main = left_col
		else:
			main = right_col
		print("main ", main)
		if main == 0:
			print("left or right col is 0")
			pointB = Vector2(450, 64)
			pointA = Vector2(153, 307)
			x_coords = [152, 174.5, 197, 219.5, 242,
						 261.75, 281.5, 301.25, 321,
						 339.25, 357.5, 375.75, 394,
						 408, 422, 436, 450]
						
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 1:
			print("left or right col is 1")
			pointB = Vector2(514, 82)
			pointA = Vector2(230, 334)
			x_coords = [229, 312, 391, 453, 514]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 2:
			print("left or right col is 2")

			pointB = Vector2(613, 54)
			pointA = Vector2(319, 369)
			x_coords = [217, 392, 460, 523, 570, 612]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 3:

			pointB = Vector2(665, 66)
			pointA = Vector2(383, 394)
			x_coords = [382, 454, 521, 580, 626, 665]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 4:

			pointB = Vector2(736, 84)
			pointA = Vector2(404, 475)
			x_coords = [451, 523, 588, 648, 696, 735]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 5:

			pointB = Vector2(795, 97)
			pointA = Vector2(474, 507)
			x_coords = [475, 521, 589, 653, 710, 757, 795]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 6:
			pointB = Vector2(866, 115)
			pointA = Vector2(555, 543)
			x_coords = [554, 603, 667, 729, 784, 829, 866]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 7:
			pointB = Vector2(925, 129)
			pointA = Vector2(735, 415)
			x_coords = [674, 736, 795, 847, 889, 926]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 8:
			pointB = Vector2(993, 145)
			pointA = Vector2(819, 334)
			x_coords = [819, 873, 921, 961, 993]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 9:
			pointB = Vector2(1018, 216)
			pointA = Vector2(887, 471)
			x_coords = [886, 937, 982, 1019]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 10:
			pointB = Vector2(1043, 229)
			pointA = Vector2(1007, 318)
			x_coords = [1007, 1043, 1072]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		if main == 11:
			pointB = Vector2(1126, 331)
			pointA = Vector2(1099, 427)
			x_coords = [1098, 1125, 1147]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]


	if side == 3 or side == 4:
		print(side)
		var main = null
		if side == 3:
			main = top_row
		else:
			main = bottom_row
		if main == 0:
			pointA = Vector2(406, 475)
			pointB = Vector2(556, 541)
			x_coords = [403, 474, 556]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 1:
			pointA = Vector2(153, 305)
			pointB = Vector2(673, 502)
			x_coords = [152, 230, 319, 383, 451, 522, 603, 674]

			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 2:
			pointA = Vector2(242, 234)
			pointB = Vector2(887, 471)
			x_coords = [244, 315, 395, 454, 521, 588, 666, 735, 818, 866]
			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 3:
			pointA = Vector2(321, 171)
			pointB = Vector2(1100, 428)
			x_coords = [322, 392, 463, 520, 588, 654, 728, 795, 874, 937, 1007, 1099]

			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 4:
			pointA = Vector2(395, 111)
			pointB = Vector2(1127, 330)
			x_coords = [395, 461, 524, 573, 647, 709, 785, 848, 921, 984, 1043, 1126]

			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 5:
			pointA = Vector2(452, 65)
			pointB = Vector2(1147, 252)
			x_coords = [410, 515, 572, 627, 698, 757, 831, 890, 962, 1018, 1072, 1147]

			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
		elif main == 6:
			pointA = Vector2(612, 55)
			pointB = Vector2(1041, 158)
			x_coords = [612, 666, 736, 801, 867, 927, 994]

			var keep = []
			for coord in x_coords:
				if coord < pointB[0] + 10 and coord > pointA[0] - 10:
					keep.append(coord)
			return [pointA, pointB, x_coords, keep]
