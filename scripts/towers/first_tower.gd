extends Node2D
var _is_body_in_area_ = false

func _ready() -> void:
	print(str(name), ": Инициализирована!")

func _physics_process(delta: float) -> void:
	if _is_body_in_area_ == true:
		print
		
func _on_area_body_entered(body: Node2D) -> void:
	_is_body_in_area_ = true
	print(str(name), ": тело ", body, " вошло в область")

func _on_area_body_exited(body: Node2D) -> void:
	_is_body_in_area_ = false
	print(str(name), ": тело ", body, " покинуло в область")
