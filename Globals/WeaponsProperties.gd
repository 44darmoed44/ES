extends Node

var swords_count = 1
var bows_count = 3

var weapons = {
	"sword" : preload("res://Characters/Player/Weapons/Sword/sword.tscn")
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