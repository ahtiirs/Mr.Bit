extends RichTextLabel

#onready var game = get_parent().get_parent().get_parent()
onready var game = get_node("/root/Bit")


# Variables
var dialog = {
	"MB":"Hei poja, tahtsid endale ehitada arvuti? Emaplaat on ainus komponent, mille mina sulle alguses annan. Sa leiad selle staabist.  Sealt saad ka oma järgmise missiooni. Jälgi juhiseid täpselt, vale asi kotis staapi sisenedes kaotad elu. Elusid on sul kokku viis. Ringi liikudes ole väga ettevaatlik! Siin valvab kuri Bogdan. Kui temaga kohtud kaotad alati ühe elu. Hätta jäädes tule räägi minuga, ehk oskan nõu anda. Edu sulle poja! ",
	"CPU":"Kas siit ei anna aju leida?",
	"RAM":"Kuhu sa oma märkmeid teed?",
	"HDD":"Vanasti oli info raamatutes!",
	"PSU":"Telefon saab energiat akudest äkki saab arvuti ka!",
	"Keyboard":"Sellel saab klahve klõbistada!",
	"OS":"Veidi imelik lugu aga kohtasin siin üht pingviini, Linux kasutab pingviini oma logona, ehk saad temalt programmi!",
	"GPU":"123",
	"Cooler":"123",
	"Speaker":"123",
	"Mouse":"123",
	"Game":"Vägin siin mingit kirevat karpi vesagil vedelemas, tundus mängu moodi olevat, mine otsi üles!"
	}


var page = 0
var paragraph = true
var kontroll = 0

onready var timer = $Timer
onready var DialogArea = get_parent()

# Functions
func _ready():

	set_bbcode(dialog[game.current_level[game.status]])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		paragraph = true
		set_visible_characters(get_total_character_count())

func _on_QuestionArea_on_dialog():

	DialogArea.visible = true
	if page < dialog.size() && paragraph == true:
		set_bbcode(dialog[game.current_level[game.status]])
		set_visible_characters(0)
		page += 1
		paragraph = false
	else:
		set_visible_characters(get_total_character_count())

	print("kontroll ",page)
	kontroll+=1
	if game.current_level[game.status] == "OS":
		game.bag = "OS"

func _on_Button_pressed():
	
	DialogArea.visible = false
	get_tree().paused = false
	pass # Replace with function body.
