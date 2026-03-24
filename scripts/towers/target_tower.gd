extends Node2D

@export var aggr_range: float
@export var self_health: int = 1000
var self_health_before: int
#@export var attack_damage: float = 10


var enemy_in_range: Array = []
#var target

func _ready() -> void:
	self_health_before = self_health
	z_index = global_position.y
	$Body/Range.scale = $Body/Range.scale*aggr_range
	

func _process(_delta: float) -> void:
	if self_health <= 0:
		queue_free()
	evil.die(self)
func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		self_health -= body.self_health
		body.queue_free() 
		enemy_in_range.append(body)

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)
