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
				"self_hp" = 50,
				"aggr_range" = 5
			},
			"stats_modifiers" : {}
		},
	"castle":
		{
			"stats":{
				"self_hp" = 150,
				"aggr_range" = 3
			},
			"stats_modifiers" : {
				"attack_damage" = -.8
			}
		},
	"ram":
		{
			"stats":{
				"self_hp" = 25,
				"aggr_range" = 6
			},
			"stats_modifiers" : {
				"attack_speed" = -.5
			}
		},
	"arsenal":
		{
			"stats":{
				"self_hp" = 45,
				"aggr_range" = 4
			},
			"stats_modifiers" : {
				"attack_damage" = 1.2
			}
		}
}
