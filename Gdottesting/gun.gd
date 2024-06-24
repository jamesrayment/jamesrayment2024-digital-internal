extends Node3D


@export var ANIMATIONPLAYER : AnimationPlayer

#damage
var damage = 50

@onready var aimcast = get_node("/root/Node3D/Player/CollisionShape3D/Neck/Camera3D/Aimcast")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Shoot"):
		_shoot()
		

func dealdamage():
	if aimcast.is_colliding():
			var target = aimcast.get_collider().get_parent()
			print(target)
			if target.is_in_group("enemy"):
				print("hit enemy")
				target.health -= damage



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _shoot():
	ANIMATIONPLAYER.play("Shoot")
