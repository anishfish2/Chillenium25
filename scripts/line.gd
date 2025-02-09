# MarkerLine.gd
extends Node2D

@export var target_height: float = 100.0
@export var duration: float = 5.0
@export var line_color: Color = "WHITE"
@export var line_width: float = 2.0

var current_height: float = 0.0
var animation_played: bool = false

# Remove tween initialization from _ready():
func _ready() -> void:
	# Do not start the tween automatically.
	set_process(false)

# Instead, start the animation when set_base_data is called.
func set_base_data(base_pos: Vector2, target_h: float, anim_duration: float) -> void:
	self.global_position = base_pos
	target_height = target_h
	duration = anim_duration
	
	# Start the tween only if it hasn’t already played.
	if not animation_played:
		set_process(true)
		var tween = create_tween()
		tween.tween_property(self, "current_height", target_height, duration) \
			 .set_trans(Tween.TRANS_LINEAR) \
			 .set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", Callable(self, "_on_tween_finished"))

func _on_tween_finished() -> void:
	animation_played = true
	set_process(false)

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	# Draw the vertical line upward (subtract from y because y increases downward in Godot)
	draw_line(Vector2.ZERO, Vector2(0, -current_height), line_color, line_width)
