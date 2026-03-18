extends Node

@onready var bg_music: AudioStreamPlayer = $bg_music
@onready var nightmare: AudioStreamPlayer = $Nightmare
@onready var death_sound: AudioStreamPlayer = $"death sound"
@onready var null_death: AudioStreamPlayer = $null_death


func play_bg_music():
	bg_music.play()
	
func play_nightmare():
	nightmare.play()
	
func play_death():
	death_sound.play()
	
func null_death_play():
	null_death.play()

var high_score = -9999999999999
var SPEED = 1000
var health = 3
var fast_fall = false
var score = 0
var difficulty = 250
var show_diff = false
var frail = false
var slow = false
var evil_drops = false
var hard_mode = false
var challenge_mult = 1
var spawn_rate = 1
var hyper = false
var blind = false
var super_gravity = false
var snail = false
var show_time = false
var ms_elapased = 0
var sec_elapased = 0
var min_elapased = 0
var health_cheat = false
var cheat_health = 3
var diff_cheat = false
var cheat_diff = 0
var speed_cheat = false
var cheat_speed = 1000
var zoom_cheat = false
var cheat_zoom = 0.5
var mult_cheat = false
var cheat_mult = 1
var spawn_cheat = false
var cheat_spawn = 0.5
var hitboxes = false
var amount_cheat = false
var cheat_amount = 1
var evil_cheat = false
var cheat_evil = 0
var fast_mode = false
var slow_mode = false
var freeze = false
var score_freeze = false
var fish_mode = false
var evil_chance = 0
var hurt = false
var upside_down = false
var false_score = 0
var teleport = false
var game_won = false
var victory = false
var victory_2 = false
var victory_3 = false
var dead = false
var no_death_skulls = false
var super_hard_mode = false
var final_score = "null"
var seeing_it = false
var cookie_1 = false
var cookie_2 = false
var cookie_3 = false
var true_end = false
