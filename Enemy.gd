extends KinematicBody2D
class_name Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null
onready var health = $Health
var speed: int = 100
var target: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health.current_value = 10
	$Area2D.connect("body_entered", self, "attack")
	$Area2D.connect("body_exited", self, "reset")
	$Attack_Timer.connect("timeout", self, "repeated_attack")
	$Health.connect("health_reach_zero", self, "die")

func die():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player == null:
		return
	
	var movement: Vector2 = self.player.global_position - self.global_position
	movement = movement.normalized()*self.speed
	self.move_and_slide(movement)
	self.look_at(self.player.global_position)

func attack(body: Node):
	if body is Player:
		body.take_damage(5, self)
		$Attack_Timer.start(2)
		self.target = body
		
func repeated_attack():
	self.target.take_damage(5, self)

func reset(body: Node):
	$Attack_Timer.stop()
	self.target = null
	
