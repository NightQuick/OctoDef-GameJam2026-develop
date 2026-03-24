class_name SmartTowers

static func math_stats(Tower: Node):
	if Tower.tower_id:
		Tower.attack_damage = ChastiBashen.towers[Tower.tower_id].stats.attack_damage
		Tower.attack_speed = ChastiBashen.towers[Tower.tower_id].stats.attack_speed
	if Tower.base_id:
		Tower.aggr_range = ChastiBashen.base[Tower.base_id].stats.aggr_range
		Tower.max_health = ChastiBashen.base[Tower.base_id].stats.max_health
		if ChastiBashen.base[Tower.base_id].has("stats_modifiers"):
			if ChastiBashen.base[Tower.base_id].stats_modifiers.has("attack_damage"):
				Tower.attack_damage += ChastiBashen.base[Tower.base_id].stats_modifiers.attack_damage
			if ChastiBashen.base[Tower.base_id].stats_modifiers.has("attack_speed"):
				Tower.attack_speed += ChastiBashen.base[Tower.base_id].stats_modifiers.attack_speed

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
