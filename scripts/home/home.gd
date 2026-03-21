extends Node2D

@onready var buildingList:Dictionary={
	$bichFactory:[$bichFactory/bichFactoryArea,'bich'],
	$townHall:[$townHall/towenHallArea,'lab'],
	$mine:[$mine/mineArea,'min'],
	$detailFactory:[$detailFactory/detailFactoryArea,'det'],
	$constructionFactory:[$constructionFactory/constructionFactoryArea,'con'],
	$laboratory:[$laboratory/laboratoryArea,'lab']
}

func _on_ready() -> void:
	for building in buildingList:
		buildingList[building][0].input_event.connect(_on_building_input_event.bind(buildingList[building][1]))

func _on_building_input_event(viewport: Node, event: InputEvent, shape_idx: int,openedBuilding) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(openedBuilding)
