extends Area2D

class_name bullet

var direction: Vector2 = Vector2.ZERO
var speed: float = 600
var active: bool = false
var delay: float = 0
var source: Node = null

func _physics_process(delta):
	if self.active:
		var movement = self.direction.normalized()
		movement *= self.speed * delta
		self.global_position += movement

func _ready():
	self.visible = false
	self.look_at(self.global_position + self.direction)
	$CollisionShape2D.disabled = true
	
	if self.delay > 0:
		#$Timer.wait_time = self.delay
		$Timer.start(self.delay)
		$Timer.connect("timeout", self, "shoot")
	else:
		self.shoot()
	
func shoot():
	self.connect("body_entered", self, "handle_hit")
	self.visible = true
	$CollisionShape2D.disabled = false 
	self.active = true
	
func handle_hit(body: Node):
	if body is StaticBody2D:
		queue_free()
		return
	
	if body is Player:
		#In attack mode, enemies can damage you
		if not body.knife.block.visible: 
			body.take_damage(5, self.source)
		#In block mode, enemies can damage you if not in blocking hitbox, otherwise will damage block hitbox
		elif not (self.overlaps_area(body.knife)):
			body.take_damage(5, self.source)
		queue_free()
