extends KinematicBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 500
onready var knife = $Knife 
onready var health = $Health
onready var shield = $Shield
onready var block_meter = $Node2D/Blockbar
var kills = 0 
var killer: Node = null


func _ready():
	self.health.connect("health_reach_zero", self, "die")

func _process(delta):
	$Node2D.set_rotation(self.rotation*-1)
	block_meter.value = knife.block_meter
	#self.block_meter.set_position(Vector2(8,11))
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
		
func take_damage(damage:int, attacker: Node) -> void:
	self.killer = attacker
	if self.shield.current_value > 0:
		self.shield.current_value -= damage
	elif self.shield.current_value == 0:
		self.health.current_value -= damage
	
