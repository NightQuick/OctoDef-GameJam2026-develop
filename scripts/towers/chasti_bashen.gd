extends Node

var towers: Dictionary = {
	"watercannon":
		{
			"stats":{
				"attack_damage" = 4,
				"attack_speed" = 1
			}
		},
	"bubblegun":
		{
			"stats":{
				"attack_damage" = 1,
				"attack_speed" = .4
			}
		},
	"whirlpool":
		{
			"stats":{
				"attack_damage" = 5,
				"attack_speed" = 1.8
			}
		}
}

var base: Dictionary = {
	"base":
		{
			"stats":{
				"max_health" = 50,
				"aggr_range" = 5
			}
		},
	"castle":
		{
			"stats":{
				"max_health" = 150,
				"aggr_range" = 3
			},
			"stats_modifiers" : {
				"attack_damage" = -.8
			}
		},
	"ram":
		{
			"stats":{
				"max_health" = 25,
				"aggr_range" = 6
			},
			"stats_modifiers" : {
				"attack_speed" = -.5
			}
		},
	"arsenal":
		{
			"stats":{
				"max_health" = 45,
				"aggr_range" = 4
			},
			"stats_modifiers" : {
				"attack_damage" = 1.2
			}
		}
}
