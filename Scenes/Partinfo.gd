extends WindowDialog

onready var staapmessage = get_parent().get_node("StaapText")
onready var staap = get_parent()

signal renewlist
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	if self.visible:
#		if Input.get_action_strength("esc"):
#			staap._partinfo_ok_pressed()
#		if Input.get_action_strength("ok"):
#			staap._partinfo_ok_pressed()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#		pass


func _on_ok_pressed():
	self.visible = false
	staapmessage.visible = true
	emit_signal("renewlist")
	pass # Replace with function body.
	
