class_name SmartTowers

static func math_stats(Tower: Node):
	Tower.attack_damage = ChastiBashen.towers[Tower.tower_id].stats.attack_damage
	Tower.attack_speed = ChastiBashen.towers[Tower.tower_id].stats.attack_speed
	Tower.aggr_range = ChastiBashen.bodies[Tower.body_id].stats.aggr_range
	Tower.max_health = ChastiBashen.bodies[Tower.body_id].stats.max_health
	if ChastiBashen.bodies[Tower.body_id].has("stats_modifiers"):
		if ChastiBashen.bodies[Tower.body_id].stats_modifiers.has("attack_damage"):
			Tower.attack_damage += ChastiBashen.bodies[Tower.body_id].stats_modifiers.attack_damage
		if ChastiBashen.bodies[Tower.body_id].stats_modifiers.has("attack_speed"):
			Tower.attack_speed += ChastiBashen.bodies[Tower.body_id].stats_modifiers.attack_speed

static func rotate_head(Tower: Node, target: Node, head: Node):
	var dir = target.global_position - Tower.global_position
	var angle_rad = dir.angle()
	var angle_deg = rad_to_deg(angle_rad)
	
	if 112.5 < angle_deg and angle_deg <= 157.5:
		head.region_rect.position.x = 0
	if (-157.5 <= angle_deg and angle_deg <= -180) or (157.5 < angle_deg and angle_deg <= 180):
		head.region_rect.position.x = 32
	if -157.5 < angle_deg and angle_deg <= -112.5:
		head.region_rect.position.x = 64
	if -112.5 < angle_deg and angle_deg <= -67.5:
		head.region_rect.position.x = 96
	if -67.5 < angle_deg and angle_deg <= -22.5:
		head.region_rect.position.x = 128
	if -22.5 < angle_deg and angle_deg <= 22.5:
		head.region_rect.position.x = 160
	if 22.5 < angle_deg and angle_deg <= 67.5:
		head.region_rect.position.x = 192
	if 67.5 < angle_deg and angle_deg <= 112.5:
		head.region_rect.position.x = 224

static func attack(Tower: Node, target: Node):
	target.self_health -= Tower.attack_damage
	if ChastiBashen.towers[Tower.tower_id].has("effects"):
		for eff in ChastiBashen.towers[Tower.tower_id].effects:
			target.effects[eff] = ChastiBashen.towers[Tower.tower_id].effects[eff].duplicate()

static func attack_anim(Tower: Node, head: Node):
	var shoot_anim = Tower.create_tween()
	var head_pos = head.position
	match head.region_rect.position.x:
		0.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x+2, head_pos.y-1), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		32.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x+3, head_pos.y), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		64.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x+2, head_pos.y+1), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		96.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x, head_pos.y+3), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		128.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x-2, head_pos.y+1), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		160.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x-3, head_pos.y), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		192.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x-2, head_pos.y-1), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)
		224.0:
			shoot_anim.tween_property(head, "position", Vector2(head_pos.x, head_pos.y-3), .1)
			shoot_anim.tween_property(head, "position", head_pos, .2)

static func select_target(Tower: Node):
	match ChastiBashen.towers[Tower.tower_id].target.sort:
		"first":
			return Tower.enemy_in_range[0]
		"last":
			return Tower.enemy_in_range[-1]
