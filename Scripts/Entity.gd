extends KinematicBody

onready var navigationAgent: NavigationAgent = $NavigationAgent
onready var sceneRoot = get_tree().get_current_scene()  # get the root node of the scene
onready var model = $character_knight
onready var selectEffect = $SelectEffect

var target_location = Vector3(0,0,0)
var velocity = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	target_location = global_transform.origin
	navigationAgent.set_target_location(target_location)
	add_to_group("units")

#move the agent to the clicked position
func _physics_process(delta):
	if navigationAgent.is_navigation_finished() and velocity.length() < 0.1:
		velocity = Vector3(0,0,0)
		return

	var direction = global_transform.origin.direction_to(navigationAgent.get_target_location())
	var desired_velocity = direction * 10
	var steering_vector = (desired_velocity - velocity) * delta * 4.0

	velocity += steering_vector

	velocity = move_and_slide(velocity)
	
func navigate_by(position):
	navigate_to(target_location+position)

func navigate_to(position):
	target_location = position
	navigationAgent.set_target_location(target_location)

func select():
	selectEffect.visible = true

func deselect():
	selectEffect.visible = false
