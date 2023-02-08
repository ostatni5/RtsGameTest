extends Control


var is_visible = false
var start_position = Vector2(0,0)
var end_position = Vector2(100,100)
var box_color = Color(.3, 1, 0.3, 0.5)
var box_width = 2

func _draw():
	if is_visible:
		draw_rect(Rect2(start_position, end_position - start_position), box_color, false, box_width)

func _process(_delta):
	update()
