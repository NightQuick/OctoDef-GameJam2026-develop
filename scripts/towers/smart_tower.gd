extends "res://scripts/towers/first_tower.gd"

func _physics_process(_delta: float) -> void:
	if enemy_in_range and tower_id and body_id:
		target = SmartTowers.select_target(self)
		SmartTowers.rotate_head(self, target, $Head)

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.append(body)

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)

func _on_attack_timeout() -> void:
	if enemy_in_range and tower_id and body_id:
		SmartTowers.attack(self, target)
		SmartTowers.attack_anim(self, $Head)
