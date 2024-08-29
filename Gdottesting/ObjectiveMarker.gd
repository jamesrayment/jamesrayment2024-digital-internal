extends Area3D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		global.money += 10
		get_node("/root/Node3D/Player").save()
		print("objective reached!")
		get_tree().create_timer(1.0)
		get_tree().quit()
