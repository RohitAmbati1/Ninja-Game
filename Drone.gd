extends KinematicBody2D
class_name Drone

# Declare member variables here. Examples:
var player = null
onready var health = $Health
onready var drone = $Sprite
onready var drone_attack = $Sprite_LitUp
var speed: int = 50
var rng = RandomNumberGenerator.new()

var phase = "move" setget set_phase

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
		if movement.length() < self.speed*delta:
			self.global_position = self.destination
			self.phase = "attack"
			
		else:
			movement = movement.normalized()*self.speed
# warning-ignore:unused_variable
			var velocity = self.move_and_slide(movement)
		self.look_at(self.player.global_position)

func set_phase(new_phase):
	if new_phase == phase:
		return
		
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", self, "prepare")
	
func prepare():
	var timer = self.get_node("Timer")
	#change sprite
	self.drone.visible = false
	self.drone_attack.visible = true
	#restart timer
	timer.start()
	#disconnect timer from prepare
	timer.disconnect("timeout", self, "prepare")
	#connect timer to shoot function
	timer.connect("timeout", self, "attack")
	#make shoot function
func attack():
	#make the bullets
	#tell them where to go
	#add them to the main scene tree
	#reset timer to trigger moving again
	pass
	
func move_again():
	#remove the timer from drone
	self.phase = "move"
	pass
	
