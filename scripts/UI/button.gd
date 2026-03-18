extends Button


func _on_pressed() -> void:
	var resolutionDropbox=$"../HBoxContainer/VBoxContainer2/resolutionDropbox"
	for i in range(1,10):
		resolutionDropbox.get_popup().add_item(str(i))
	for i in range(resolutionDropbox.get_popup().get_item_count()):
		print(resolutionDropbox.get_popup().get_item_submenu_node(i))
		
	
