extends KinematicBody2D
class_name Drone

# Declare member variables here. Examples:
var player = null
onready var health = $Health
onready var drone = $Sprite
onready var drone_attack = $Sprite_LitUp
var speed: int = 50
var rng = RandomNumberGenerator.new()

var phase = "move"
var destination: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	self.health.current_value = 40
	self.drone_attack.visible = false
	rng.randomize()
	self.destination = Vector2(rng.randf_range(100,924),rng.randf_range(100,500))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player == null:
		return
	
	if self.phase == "move":
		var movement: Vector2 = self.destination - self.global_position
		movement = movement.normalized()*self.speed
		self.move_and_slide(movement)
		self.look_at(self.player.global_position)
