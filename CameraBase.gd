extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal click(position)

const MIN_SELECTION_SIZE = 5

onready var clickIndicator = get_node("../ClickIndicator")
onready var selectionBox = get_node("SelectionBox")
var start_selection_pos = Vector2()
var end_selection_pos = Vector2()

var is_selecting = false
var selected_units = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _input(event):
	if event.is_action_pressed("game_selection"):
		start_selection_pos = event.position
		is_selecting = true

	if event.is_action_released("game_selection"):
		end_selection_pos = event.position
		is_selecting = false

		if start_selection_pos.distance_to(end_selection_pos) > MIN_SELECTION_SIZE:
			_select_in_area(start_selection_pos, end_selection_pos)
		else:
			_click()

		selectionBox.is_visible = false

	if event is InputEventMouseMotion and is_selecting:
		if start_selection_pos.distance_to(event.position) > MIN_SELECTION_SIZE:
			selectionBox.is_visible = true
			selectionBox.start_position = start_selection_pos
			selectionBox.end_position = event.position
		else:
			selectionBox.is_visible = false


func _click():
	# get mouse position
	var cursorPos = get_viewport().get_mouse_position()
	# get raycast from mouse position
	var rayOrigin = get_viewport().get_camera().project_ray_origin(cursorPos)
	# get collision from raycast
	var rayEnd = get_viewport().get_camera().project_ray_normal(cursorPos)
	var raycast = get_world().direct_space_state
	var collision = raycast.intersect_ray(rayOrigin, rayOrigin + rayEnd * 1000)

	# if collision is not null, print position of collision
	if collision != null:
		if collision.collider.has_method("select"):
			_unselect_all()
			_select_node(collision.collider)
		else:		
			clickIndicator.global_transform.origin = collision.position
			emit_signal("click", collision.position)
			clickIndicator.get_node("AnimationPlayer").stop()
			clickIndicator.get_node("AnimationPlayer").play("Click")

			for unit in selected_units:
				if unit.has_method("navigate_to"):
					unit.navigate_to(collision.position)


func _unselect_all():
	for unit in selected_units:
		unit.deselect()
	selected_units = []

func _select_node(node):
	node.select()
	selected_units.append(node)


func _select_in_area(start, end):
	_unselect_all()

	var top_left = _get_left_top_corner(start, end)
	var area = Rect2(top_left, (end - start).abs())
	var nodes = get_tree().get_nodes_in_group("units")

	for node in nodes:
		if area.has_point(
			get_viewport().get_camera().unproject_position(node.global_transform.origin)
		):
			_select_node(node)


func _get_left_top_corner(start, end):
	var left = min(start.x, end.x)
	var top = min(start.y, end.y)
	return Vector2(left, top)
