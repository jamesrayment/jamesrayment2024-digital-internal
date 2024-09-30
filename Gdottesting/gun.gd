extends Node3D


@export var ANIMATIONPLAYER : AnimationPlayer

#damage
var damage = 20

#reload check
var reloading = false

#ammo
var ammo = 0
var pistolmaxammo = 10

@onready var aimcast = get_node("/root/Node3D/Player/CollisionShape3D/Neck/Camera3D/Aimcast")

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = 10
	$Debris_particles.emitting = false

func _input(event):
	if event.is_action_pressed("Shoot") and reloading == false:
		if ammo > 0:
			_shoot()
		else:
			pass
	else:
		pass
		
	if event.is_action_pressed("Reload") and reloading == false:
		reloading = true
		_reload()
		
		

func dealdamage():
	ammo -= 1
	print(ammo)
	get_node("/root/Node3D/Player/CollisionShape3D/Neck/currentammo").text = str(ammo)
	if aimcast.is_colliding():
			var target = aimcast.get_collider()
			print(target)
			if target.is_in_group("enemy"):
				print("hit enemy")
				target.health -= damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _shoot():
	if $Debris_particles.emitting == false:
		ANIMATIONPLAYER.play("Shoot")
		$Debris_particles.emitting = true
	else:
		$Debris_particles.restart
		_shoot()

func _reload():
	ANIMATIONPLAYER.play("Reload")
	
func reloadfinish():
	ammo = 10
	print(ammo)
	get_node("/root/Node3D/Player/CollisionShape3D/Neck/currentammo").text = str(ammo)
	reloading = false
	
