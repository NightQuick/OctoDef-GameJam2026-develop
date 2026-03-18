extends VBoxContainer
@onready var option_button: OptionButton = $OptionButton
var listResolutions:Dictionary={
	"1920x1080":Vector2(1920,1080),
	"1280x720":Vector2(1280,720),
	"1024x768":Vector2(1024,768),
	"768x768":Vector2(768,768)
}



func addResolutions():
	for res in listResolutions:
		option_button.add_item(res)


func _on_option_button_item_selected(index: int) -> void:
	var ID=option_button.get_item_text(index)
	get_window().size=listResolutions[ID]


func _on_node_3d_ready() -> void:
	addResolutions()
