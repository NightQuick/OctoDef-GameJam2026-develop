extends CharacterBody2D

@onready var NavigationAgent: NavigationAgent2D = $NavigationAgent2D
#@onready 
var self_speed = 2

func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	NavigationAgent.target_position = mouse_position
	
	
	var self_position = global_position
	var next_path_position = NavigationAgent.get_next_path_position()
	var new_velocity = self_position.direction_to(next_path_position) * self_position
	var LKM = Input.is_action_just_pressed("mouse_left_button") 
	if LKM:
		print("2132321")
	
	if NavigationAgent.is_navigation_finished():
		return 
	
	if NavigationAgent.avoidance_enabled:
		NavigationAgent.set_velocity(new_velocity) 
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	move_and_slide()
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
