extends Node2D

#var status = 5
var status = 7
var level= 2
var bag = "empty"
var pc = [
	"MB",
	"CPU",
	"RAM",
	"HDD",
	"PSU",
	"Keyboard",
	"OS"
]
#var pc = [	
#	"MB",
#	"CPU",
#	"RAM",
#	"HDD",
#	"PSU",
#	"Keyboard"
#	]
	
var current_level = [
	"MB",
	"CPU",
	"RAM",
	"HDD",
	"PSU",
	"Keyboard",
	"OS",
	"GPU",
	"Cooler",
	"Soundcard",
	"Speaker",
	"Mouse",
	"Game",
	"Game Over"
	]
	
var ok_button = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
#var level1 = [
#	"MB",
#	"CPU",
#	"RAM",
#	"HDD",
#	"PSU",
#	"Keyboard",
#	"OS"
#	]
	
#var ok_button_l1 = [1,0,0,0,0,0,0]
#var level2 = ["Mouse","Cooler","GPU","Soundcard","Speaker","Mic"]
#var ok_button_l2 = [0,0,0,0,0,0,0]

onready var live1 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda1")
onready var live2 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda2")
onready var live3 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda3")
onready var live4 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda4")
onready var live5 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda5")
onready var mist = get_node("walls/GUI/Uduekraan")
onready var timer = get_node("walls/GUI/Uduekraan/Timer")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Player_lives(lives):

	mist.visible=true
	timer.start()
	get_tree().paused = true

	print(lives)
	if lives >= 1:
		live1.visible=true
	else:
		live1.visible=false
	if lives >= 2:
		live2.visible=true
	else:
		live2.visible=false
	if lives >= 3:
		live3.visible=true
	else:
		live3.visible=false
	if lives >= 4:
		live4.visible=true
	else:
		live4.visible=false
	if lives >= 5:
		live5.visible=true
	else:
		live5.visible=false
	pass


func _on_Timer_timeout():
	mist.visible=false
	print("imer lõpetas, mist maha")
	get_tree().paused = false


func _on_Staap_levelup():
#	level=level+1
#	current_level=level2
#	ok_button=ok_button_l2
#	var status = 0
#	bag = "empty"
	pass