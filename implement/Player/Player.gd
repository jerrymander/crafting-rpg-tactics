extends Node

var hp = 8
var ap = 12

func description():
	return "You!"

func hp_add(amount):
	hp += amount

func ap_add(amount):
	ap += amount