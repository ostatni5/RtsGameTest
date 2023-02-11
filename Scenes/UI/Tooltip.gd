extends Node

export var TimeToAppear = 1
var parent = get_parent()

func _ready():
	pass # Replace with function body.

func showTooltip():
	get_node("Panel").show()
	
func hideTooltip():
	get_node("Panel").hide()

func parent_mouse_entered():
	get_node("Timer").start(TimeToAppear)

func parent_mouse_exit():
	get_node("Timer").stop()
	hideTooltip()

func timer_timeout():
	showTooltip()
	get_node("Panel").set_begin(get_viewport().get_mouse_position())
