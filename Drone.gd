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

var bullet_scene = preload("res://Bullet.tscn")

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
	
	if phase == "attack":
		var timer = $Timer
		timer.wait_time = 0.5
		timer.connect("timeout", self, "prepare")
		timer.start()
	
func prepare():
	var timer = $Timer
	#change sprite
	self.drone.visible = false
	self.drone_attack.visible = true
	#restart timer
	timer.wait_time = 1
	#connect timer to shoot functions
	timer.disconnect("timeout",self, "prepare")
	timer.connect("timeout", self, "attack")
	timer.start()

func attack():
	var timer = $Timer
	timer.disconnect("timeout", self, "attack")
	for i in range(3):
		#make the bullets
		var bullet = self.bullet_scene.instance()
		#tell them where to go
		bullet.direction = Vector2(cos(self.rotation), sin(self.rotation))
		bullet.global_position = self.global_position
		bullet.delay += 0.25*i
		#add them to the main scene tree
		GlobalSignals.emit_signal("spawn_bullet", bullet)
	#reset timer to trigger moving again
	timer.connect("timeout", self, "move_again")
	timer.start()
	
func move_again():
	#remove the timer from drone
	self.phase = "move"
	self.destination = Vector2(rng.randf_range(100,924),rng.randf_range(100,500))
	self.drone.visible = true
	self.drone_attack.visible = false
	var timer = $Timer
	timer.disconnect("timeout", self, "move_again")
	
