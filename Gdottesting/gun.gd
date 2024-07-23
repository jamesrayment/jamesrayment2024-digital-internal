extends Node3D


@export var ANIMATIONPLAYER : AnimationPlayer

#damage
var damage = 50

#reload check
var reloading = false

#ammo
var ammo = 0

@onready var aimcast = get_node("/root/Node3D/Player/CollisionShape3D/Neck/Camera3D/Aimcast")

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = 10

func _input(event):
	if event.is_action_pressed("Shoot") and reloading == false:
		if ammo > 0:
			_shoot()
		else:
			pass
	else:
		pass
		
	if event.is_action_pressed("Reload"):
		reloading = true
		_reload()
		

func dealdamage():
	ammo -= 1
	print(ammo)
	get_node("/root/Node3D/Player/CollisionShape3D/Neck/currentammo").text = str(ammo)
	if aimcast.is_colliding():
			var target = aimcast.get_collider().get_parent()
			print(target)
			if target.is_in_group("enemy"):
				print("hit enemy")
				target.health -= damage

func reload():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _shoot():
	ANIMATIONPLAYER.play("Shoot")

func _reload():
	ANIMATIONPLAYER.play("Reload")
	
func reloadfinish():
	ammo = 10
	print(ammo)
	get_node("/root/Node3D/Player/CollisionShape3D/Neck/currentammo").text = str(ammo)
	reloading = false
	
