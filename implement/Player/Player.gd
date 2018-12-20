extends Node

var max_hp = 8
var max_ap = 12

var hp = 8
var ap = 12
var strength = 5
var defense = 0


var crafting_levels = {}

var level = 1

var skill_levels = {}

func description():
	return "You!"

func hp_add(amount):
	hp += amount
	if hp > max_hp:
		hp = max_hp

func ap_add(amount):
	ap += amount
	if ap > max_ap:
		ap = max_ap