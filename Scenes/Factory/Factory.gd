extends Spatial

export(Resource) var spawn_class



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn():
	#print("SPAWN")
	var entity = spawn_class.instance()
	var parent_node = get_parent()
	parent_node.add_child(entity)
	entity.translate(global_transform.origin)


func _on_Timer_timeout():
	spawn()
	pass # Replace with function body.
