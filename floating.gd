extends Node

const FLOAT_STRENGTH: float = 2.0
const FLOAT_FREQUENCY: float = 3.0

var timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta  * FLOAT_FREQUENCY
	self.get_parent().position.y = sin(timer) * FLOAT_STRENGTH
