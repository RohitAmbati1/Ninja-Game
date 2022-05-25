extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_scene = preload("res://Enemy.tscn")
var rng = RandomNumberGenerator.new()
onready var player: Player = get_node("../Player")

func spawn_enemy():
	var enemy_instance: Enemy = enemy_scene.instance()
	enemy_instance.global_position = Vector2(rng.randf_range(0,924),rng.randf_range(0,500))
	enemy_instance.player = self.player
	self.add_child(enemy_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in range(4):
		self.spawn_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
