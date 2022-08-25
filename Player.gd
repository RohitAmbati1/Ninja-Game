extends KinematicBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 300
onready var knife = $Knife 
onready var health = $Health
onready var shield = $Shield
var killer: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	self.health.connect("health_reach_zero", self, "die")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func die():
	print("died")
	
func _physics_process(delta):
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("up"):
		movement += Vector2.UP
	if Input.is_action_pressed("down"):
		movement += Vector2.DOWN
	if Input.is_action_pressed("left"):
		movement += Vector2.LEFT
	if Input.is_action_pressed("right"):
		movement += Vector2.RIGHT
	
	movement = movement.normalized() * self.speed
	self.move_and_slide(movement)
	
	self.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("attack"):
		self.knife.attack()
	if Input.is_action_just_pressed("draw"):
		pass
		
func take_damage(damage:int, attacker: Node) -> void:
	self.killer = attacker
	if self.shield.current_value > 0:
		self.shield.current_value -= damage
	elif self.shield.current_value == 0:
		self.health.current_value -= damage
	
