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
	
	phase = new_phase
	
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 0.5
	timer.name = "Timer"
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "prepare")
	
func prepare():
	print("prepared "+self.name)
	var timer = self.get_node("Timer")
	#self.remove_child(timer)
	timer.queue_free()
	#change sprite
	self.drone.visible = false
	self.drone_attack.visible = true
	#restart timer
	timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 0.5
	timer.name = "Timer2"
	timer.one_shot = true
	add_child(timer)
	#connect timer to shoot function
	timer.connect("timeout", self, "attack")

func attack():
	print ("attack "+self.name)
	var timer = self.get_node("Timer2")
	timer.disconnect("timeout", self, "attack")
	#make the bullets
		#tell them where to go
		#add them to the main scene tree
	#reset timer to trigger moving again
	timer.connect("timeout", self, "move_again")
	timer.start()
	
func move_again():
	#remove the timer from drone
	self.phase = "move"
	self.destination = Vector2(rng.randf_range(100,924),rng.randf_range(100,500))
	pass
	
