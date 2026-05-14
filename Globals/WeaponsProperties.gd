extends Node

var swords_count = 1

var weapons = {
	"sword" : preload("res://Characters/Player/Weapons/Sword/sword.tscn")
}

var sword_prop = {
	"max_level" : 4,
	1 : {"dmg" : 5,"as" : 1.25},
	2 : {"dmg" : 10,"as" : 1},
	3 : {"dmg" : 15,"as" : .75},
}

var bomb_prop = {
	"max_level" : 3,
	1 : {"dmg" : 5,"as" : 1.25},
	2 : {"dmg" : 15,"as" : .75},
	3 : {"dmg" : 30,"as" : .25},
}