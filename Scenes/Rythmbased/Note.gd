extends ColorRect

export var speed = 50
export var width = 10

signal note_hit()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_width(width)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_position(get_position()-Vector2(speed,0)*delta)
	if(Input.is_action_just_pressed("rythm_control") && get_parent().get_node("Strumbar").get_position().x > get_position().x && get_parent().get_node("Strumbar").get_position().x < get_position().x+width):
		if(Input.is_action_just_pressed("order_up")):
			get_tree().call_group("units", "navigate_by", Vector3(0,0,-10))
		if(Input.is_action_just_pressed("order_down")):
			get_tree().call_group("units", "navigate_by", Vector3(0,0,10))
		if(Input.is_action_just_pressed("order_right")):
			get_tree().call_group("units", "navigate_by", Vector3(10,0,0))
		if(Input.is_action_just_pressed("order_left")):
			get_tree().call_group("units", "navigate_by", Vector3(-10,0,0))
		free()
	else:
		if(get_begin().x+width < 0):
			free()

func set_width(new_width):
	width = new_width
	set_size(Vector2(width, 100))
