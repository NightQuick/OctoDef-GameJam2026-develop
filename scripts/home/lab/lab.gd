extends Node2D

var parent_areas: Array
var child_areas: Array

func _ready() -> void:
	parent_areas = get_tree().get_nodes_in_group("Parent")
	child_areas = get_tree().get_nodes_in_group("Child")
	for area in parent_areas:
		area.input_event.connect(_on_parent_input_event)
	for area in child_areas:
		area.input_event.connect(_on_child_input_event)

func _process(delta: float) -> void:
	pass

func _on_parent_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
	
func _on_child_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.


func _on_parent_previous_pressed() -> void:
	pass # Replace with function body.
func _on_parent_next_pressed() -> void:
	pass # Replace with function body.
func _on_child_previous_pressed() -> void:
	pass # Replace with function body.
func _on_child_next_pressed() -> void:
	pass # Replace with function body.
