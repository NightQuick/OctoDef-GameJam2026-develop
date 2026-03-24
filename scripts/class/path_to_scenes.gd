class_name scenes_path
extends Node2D

static var spawner : PackedScene = preload("res://nodes_scenes/mobs/spawner.tscn")
static var tank : PackedScene = preload("res://nodes_scenes/mobs/angry/Tank.tscn")
static var damager : PackedScene = preload("res://nodes_scenes/mobs/angry/Damager.tscn")
static var scooter : PackedScene = preload("res://nodes_scenes/mobs/angry/Scooter.tscn")
static var evil_seven_node : PackedScene = preload("res://nodes_scenes/mobs/angry/evil_seven.tscn")
static var target_tower_node : PackedScene = preload("res://nodes_scenes/towers/target_tower.tscn")

static var hp_bar : PackedScene = preload("res://nodes_scenes/UI/hp_bar.tscn")
