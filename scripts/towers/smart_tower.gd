extends Node2D

@export var tower_id: String = ''
@export var base_id: String = ''
@export var module_id: String = ''

@export var aggr_range: float = 0
@export var attack_damage: float = 0
@export var attack_speed: float = 0
@export var self_health: float = 0

var enemy_in_range: Array = []
var target

func _ready() -> void:
	z_index = global_position.y
	
	$Body/Range.scale = $Body/Range.scale*aggr_range
	$Attack.wait_time = attack_speed

func _physics_process(_delta: float) -> void:
	pass

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.append(body)

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)

func _on_attack_timeout() -> void:
	pass

func math_stats()
