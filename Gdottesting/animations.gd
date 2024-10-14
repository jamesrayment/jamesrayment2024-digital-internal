extends Node3D

signal enemy_death_anim

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func death_finish():
	emit_signal("enemy_death_anim")
