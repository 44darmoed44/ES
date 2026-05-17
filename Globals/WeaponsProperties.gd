extends Node

var swords_count = 0
var bows_count = 0

var weapons = {
	"sword" : preload("res://Characters/Player/Weapons/Sword/sword.tscn"),
	"bow" : preload("res://Characters/Player/Weapons/Bow/bow.tscn"),
	"bomb" : preload("res://Characters/Player/Weapons/Bomb/bomb.tscn"),
	"musket" : preload("res://Characters/Player/Weapons/Musket/musket.tscn")
}

var wtypes = {
	"sword" : preload("res://Characters/Player/Weapons/Sword/sword.gd"),
	"bomb" : preload("res://Characters/Player/Weapons/Bomb/bomb.gd"),
	"bow" : preload("res://Characters/Player/Weapons/Bow/bow.gd"),
	"musket" : preload("res://Characters/Player/Weapons/Musket/musket.gd")
}


var max_levels = {
	"sword" : 8,
	"bow" : 9,
	"bomb" : 3,
	"musket" : 3
}

var sword_prop = {
	"max_level" : 3,
	1 : {"dmg" : 5,"as" : 1.25},
	2 : {"dmg" : 10,"as" : 1},
	3 : {"dmg" : 15,"as" : .75},
}

var bomb_prop = {
	"max_level" : 3,
	1 : {"dmg" : 5,"as" : 1.5, "num" : 1},
	2 : {"dmg" : 15,"as" : 1, "num" : 2},
	3 : {"dmg" : 30,"as" : .75, "num" : 3},
}

var bow_prop = {
	"max_level" : 3,
	1 : {"dmg" : 3,"as" : 1},
	2 : {"dmg" : 7,"as" : .75},
	3 : {"dmg" : 15,"as" : .5},
}

var musket_prop = {
	"max_level" : 3,
	1 : {"shrp_dmg" : 3, "cd" : 3, "bll_dmg" : 2, "shrpn_num" : 3},
	2 : {"shrp_dmg" : 7, "cd" : 2, "bll_dmg" : 4, "shrpn_num" : 6},
	3 : {"shrp_dmg" : 15, "cd" : 1, "bll_dmg" : 8, "shrpn_num" : 9},
}