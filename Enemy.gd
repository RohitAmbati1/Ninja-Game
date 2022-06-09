extends KinematicBody2D
class_name Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null
onready var health = $Health
var speed: int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health.current_value = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player == null:
		return
	
	var movement: Vector2 = self.player.global_position - self.global_position
	movement = movement.normalized()*self.speed
	self.move_and_slide(movement)
	self.look_at(self.player.global_position)
