extends Node2D


var instructions_open = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	$Label2.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Show and hide screen
func _input(event):
	if event.is_action_pressed("Controls") and instructions_open == false:
		$Label.show()
		$Label2.show()
		instructions_open = true
	elif event.is_action_pressed("Controls") and instructions_open == true:
		$Label.hide()
		$Label2.hide()
		instructions_open = false
