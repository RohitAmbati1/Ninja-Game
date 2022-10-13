extends Node
var drone_scene = preload("res://Drone.tscn")
var enemy_scene = preload("res://Enemy.tscn")
var rng = RandomNumberGenerator.new()
onready var player: Player = get_node("../Player")
var spawning: Array = []
var enemy_waves: int = 0
var drone_waves: int = 0


func _ready():
	rng.randomize()
	for i in self.get_children():
		if i is Position2D:
			self.spawning.append(i.global_position)
	$enemyspawn.connect("timeout", self, "spawn_enemy_wave")
	
	for i in self.get_children():
		if i is Position2D:
			self.spawning.append(i.global_position)
	$dronespawn.connect("timeout", self, "spawn_drone_wave")

func spawn_enemy_wave():
	self.enemy_waves += 1
	for wave in range(self.enemy_waves):
		for position in self.spawning:
			self.spawn_enemy(position)
	$enemyspawn.start(3*log(self.enemy_waves)+5)

func spawn_drone_wave():
	self.drone_waves += 1
	for wave in range(self.drone_waves):
		for position in self.spawning:
			self.spawn_drones(position)
	$dronespawn.start(3*log(self.drone_waves)+10)
		
func spawn_enemy(position: Vector2):
	var enemy_instance: Enemy = enemy_scene.instance()
	enemy_instance.global_position = position + Vector2(rng.randf_range(-10.0, 10.0), rng.randf_range(-10.0, 10.0))
	enemy_instance.player = self.player
	self.add_child(enemy_instance)
	
func spawn_drones(position: Vector2):
	var drone_instance: Drone = drone_scene.instance()
	drone_instance.global_position = position + Vector2(rng.randf_range(-10.0, 10.0), rng.randf_range(-10.0, 10.0))
	drone_instance.player = self.player
	self.add_child(drone_instance)
