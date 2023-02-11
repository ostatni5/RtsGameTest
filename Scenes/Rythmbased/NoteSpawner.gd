extends Panel

export var bpm = 120
export var note_width = 20
export(Resource) var note_class

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Timer").wait_time = (60.0/bpm)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_note():
	var entity = note_class.instance()
	var parent_node = get_parent()
	parent_node.add_child(entity)
	entity.speed = bpm
	entity.set_width(note_width)
	entity.set_position(get_position())

func _on_Timer_timeout():
	spawn_note()
	pass # Replace with function body.
