extends Node

var name

export var max_hp = 100
var hp = 100

export var strength = 10
export var defense = 10

var size

func _init(name):
	pass 

func take_damage(damage):
	hp = hp - damage

func heal(heals):
	hp = hp + heals

func set_strength(number):
	strength = number

func add_strength(amount):
	strength += amount

func behavior():
	pass

