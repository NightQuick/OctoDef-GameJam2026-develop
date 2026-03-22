extends Node2D


func _on_ready() -> void:
	print(FactoryGlobal.factoryType)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		$Camera2D.zoomChange(true)
	elif Input.is_action_just_pressed("scroll_down"):
		$Camera2D.zoomChange(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask==1:
		$Camera2D.moveCamera(event.relative.x,event.relative.y)
