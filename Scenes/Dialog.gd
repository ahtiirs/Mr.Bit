extends RichTextLabel

# Variables
var dialog = [
	"Tere poja tahtsid endale ehitada arvuti. Emaplaat on ainus komponent, mis mul õnnestus leida. Selle leiad staabist.  Selleks, et saaksid terve arvuti valmis teha on aga oluliselt rohkem komponente vaja. Siin sõjaväe linnakus on kõik vajalik olemas. Aga pane tähele, siin on kuri Bogdan, kes valvab perimeetrit, hoidu temast kindlasti! ",
	"Jälle sa siin, kas ikka vaatasid staabist järele mida tegema pead?",
	"Aaa sul on protsessorit vaja, no otsi vaata, arvuti mõtleb protsessoriga, mõtle millega sina mõtled!",
	"No mõtle peaga, on sul seal aju millega mõelda, leia endale siis kui pole!",
	"Viiies dialood, öoisajcdö oisajdöoiajvf a",
	"Kuues oij öcoisajdöoj afdoijvösoifdjövsoi öboijetröbweotij!"]
var page = 0
var paragraph = true
var kontroll = 0

onready var timer = $Timer

# Functions
func _ready():

	set_bbcode(dialog[page])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		paragraph = true
		set_visible_characters(get_total_character_count())

#	print(get_visible_characters())


func _on_Dialogarea_dialog_start():
		
	if page < dialog.size() && paragraph == true:
		set_bbcode(dialog[page])
		set_visible_characters(0)
		page += 1
		paragraph = false
	else:
		set_visible_characters(get_total_character_count())

	print("kontroll ",page)
	kontroll+=1