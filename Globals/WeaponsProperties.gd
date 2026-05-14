extends Node

var weapons = {
	"sword" : preload("res://Characters/Player/Weapons/Sword/sword.tscn")
}

var sword_prop = {
	"max_level" : 4,
	1 : {"dmg" : 5,"as" : 1.25},
	2 : {"dmg" : 10,"as" : 1},
	3 : {"dmg" : 15,"as" : .75},
}