extends Node

# stats
var speed = 150
var max_hp = 1000

# level system
var current_xp = 0
var xp_next_lvl = 10
var player_lvl = 1
var next_lvl_xp_mult = 1

# W&I
var weapons = {
    "sword" : 0,
    "bow" : 0,
    "musket" : 0,
    "bomb" : 0
}