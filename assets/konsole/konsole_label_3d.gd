extends Label3D
class_name KonsoleLabel

signal autodestroy_label

# value in seconds to dissolve label
@export var delay : float = 5
@export var fixed : bool = true
@export var msg : String = "~"

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = msg
	if fixed:
		font_size = 8
		outline_size = 0
		modulate = Color(0, 0, 0, 1)
		horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		position.x += -0.5
	else:
		$Timer.wait_time= delay
		$Timer.start($Timer.wait_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !fixed:
		counter += delta
		var value = remap(counter, 0, delay, 1, 0)
		modulate = Color(1, 1, 1, value)
		outline_modulate = Color(0,0,0,value)
		position.y += delta * 0.5

func _on_timer_timeout() -> void:
	autodestroy_label.emit(self)
