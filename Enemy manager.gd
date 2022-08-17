extends Node

var enemy_scene = preload("res://Enemy.tscn")
var rng = RandomNumberGenerator.new()
onready var player: Player = get_node("../Player")
var spawning: Array = []
var waves: int = 0


func _ready():
	rng.randomize()
	for i in self.get_children():
		if i is Position2D:
			self.spawning.append(i.global_position)
	$Timer.connect("timeout", self, "spawn_wave")

func spawn_wave():
	self.waves += 1
	print("started wave %s" % self.waves)
	for wave in range(self.waves):
		for position in self.spawning:
			self.spawn_enemy(position)

func spawn_enemy(position: Vector2):
	var enemy_instance: Enemy = enemy_scene.instance()
	enemy_instance.global_position = position
	enemy_instance.player = self.player
	self.add_child(enemy_instance)
