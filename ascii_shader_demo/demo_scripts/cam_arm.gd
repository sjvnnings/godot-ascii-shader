#A basic script that rotates the camera about the world up axis.
extends Spatial

export var speed = 10.0

func rot(delta):
	rotate_y(deg2rad(speed * delta))

func _process(delta):
	rot(delta)
