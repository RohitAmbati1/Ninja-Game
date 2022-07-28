extends Area2D

class_name bullet

var direction: Vector2 = Vector2.ZERO
var speed: float = 600
var active: bool = false

func _physics_process(delta):
	if self.active:
		var movement = self.direction.normalized()
		movement *= self.speed * delta
		self.global_position += movement

func _ready():
	#self.connect("body_entered", self, "handle_hit")
	$Timer.connect("timeout", self, "shoot")
	self.visible = false
	$CollisionShape2D.disabled = true
	
func shoot():
	self.connect("body_entered", self, "handle_hit")
	self.visible = true
	$CollisionShape2D.disabled = false 
	self.active = true
	

func handle_hit(body: Node):
	if body is StaticBody2D:
		queue_free()
	


