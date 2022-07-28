extends Node

func _ready():
	GlobalSignals.connect("spawn_bullet", self, "shoot_bullet")
	
func shoot_bullet(bullet):
	self.add_child(bullet)
	
