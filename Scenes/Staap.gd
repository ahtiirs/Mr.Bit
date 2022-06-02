extends Node2D

var staapText = {
	"MB":"Sulle on siin monitor ja arvuti korpus  milles on emaplaat. Ülejäänud vajaliku arvuti tööle saamiseks pead leidma vanalt tehase territooriumilt. Kui sa jääd hätta, pöördu ema poole, ta aitab. Ära teda aga liialt tihti tüüta, ema elu pole kerge. Kui liigud ringi, ole ettevaatlik, Bogdan on kuri ja temaga kohtudes jääd iga kord ilma ühest võimalusest arvuti kokku saada. Võimalusi on sul viis.",
	"CPU":"Leia protsessor, see on nagu arvuti aju , mis kinnitub emaplaadi külge. See aitab arvutil teostada tehteid ja arvutusi, ning juhib teiste seadmete tööd. Protsessori leiad sümboli juurest, mis vihjab mõtlemisele. Head otsimist!",
	"RAM":"Leia muutmälu, selle poole saab pöörduda  ühteviisi kiirelt nii lugemiseks, kui ka kirjutamiseks.",
	"HDD":"Leia kõvaketas, sinna saab suurel hulgal infot talletada ja seda sealt ka lugeda vastavalt vajadusele.",
	"PSU":"Leia toiteplokk, toiteplokist saab voolu arvuti töötamiseks",
	"Keyboard":"Leia klaviatuur, klaviatuuril on erinevad klahvid, mida saab vajutada ja anda sisendi arvutile.",
	"OS":"Tühi kott ei seisa püsti, samuti ei tööta ka arvuti ilma tarkuseta. Mine küsi emalt veidi tarkust mida arvutisse panna. Seda nimetatakse OP süsteemiks.",
	"Mouse":"",
	"Cooler":""
	}


var partText = {
	"MB":"Emaplaat on trükiplaat arvutis, mille sees ja peal on erinevaid elektroonika radu ja seadiseid. Rajad omakorda moodustavad siinid, mida mööda liiguvad andmed erinevate siseseadmete ja ka välisseadmetele.Emaplaadile ühendatakse kõik arvuti siseseadmed ja ka kaudselt kõik välisseadmed",
	"CPU":"See on arvuti aju ehk keskseade, mis on kinnitatud emaplaadi külge. Kiip sooritab arvuti jaoks vajalikud arvutused. Teostab tehteid ja arvutusi, lisaks teiste seadmete töö juhtimist.",
	"RAM":"on arvuti keskne mäluseade, kuhu saab andmeid kirjutada ja kust saab neid lugeda. Suvapöördus (random access) tähendab seda, et igal mälupesal on oma aadress ning nii lugemiseks kui kirjutamiseks on võimalik pöörduda suvalise aadressi poole. Enamik muutmälusid pole säilmälud, s.t. toite väljalülitamisel mälus olevad andmed hävivad.",
	"HDD":"Arvuti kõvaketas on peamiseks andmekandjaks. Kõvaketas on jäigast materjalist ketas, mis on kaetud magnetiseeruva materjali kihiga, mis omakorda annab võimaluse kõvakettale andmeid salvestada",
	"PSU":"",
	"Keyboard":"",
	"OS":"",
	"Mouse":"",
	"Cooler":""
	}


onready var game = get_parent().get_parent()
onready var mother = get_parent().get_parent().get_node("Mother")
onready var player = get_parent().get_parent().get_node("Player")
onready var staapvideo = get_node("StaapStart")
onready var staapvideoKeyb = get_node("StaapStart_Keyb")
onready var level1end = get_node("Level1_end")
onready var staapmessage = get_node("StaapText")
onready var intheBag = get_parent().get_node("inTheBag")
onready var componentInfo = get_node("Partinfo")
onready var progres = .get_parent().get_node("Panel_P/GameLevel")

signal lives
signal levelup



func _ready():
	
	pass # Replace with function body.


func _on_StaapEntrance_body_entered(body):

	print("Ema kotis ", mother.bag)
	if body.name == "Player":
		intheBag.visible = false
		if game.ok_button_l1[game.status] == 1:
			self.get_node("StaapText/ok").visible = true
			self.get_node("Exit").visible = false
			
# Olemasolevate juppide järgi otsustatakse milist taustavideot mängitakse
		self.get_node("Exit").visible = true  
		get_tree().paused = true
		if game.pc.has("Speaker"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()
		elif game.pc.has("Keyboard"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()
		else:
			staapvideo.visible = true
			staapvideo.play()
# -----------------------------------------------------------------------

func _on_StaapStart_videoFinish():		#Staapi sisenemise video lõppes, tuleb vaadata kas poiss tuli õige jupp kotis

	# kui kotis pole mänguetapile vastav jupp ning kott pole märkega "empty" siis üks elu maha
	if game.current_level[game.status] != game.bag && game.bag !="empty": 
		player.lives = player.lives -1
		emit_signal("lives",player.lives)
			

	staapmessage.visible = false
	
	#Kott on tühi aga eelnevalt on klaviatuur juba olemas 
	if game.bag == "empty" && game.pc.has("Keyboard"):
		game.bag = "empty_keyb"
		
	progres.value = int((game.status+1)*100/8) # progress edenemine

	
#	game.bag = "OS" # katse kui on vaja kohe level lõppu simuleerida


	# kui saabus OS siis on level 1 läbi
	if game.bag == "OS":
		level1end.visible = true
		level1end.play()

	else:
		var component = get_node(game.bag) #tuualse pilt kotiga mis vastas kotis olevale muutujale
		component.visible = true


	# 
	staapmessage.get_node("label").text = staapText[game.current_level[game.status]]	
		
	if game.current_level[game.status] == game.bag:  #Mängija sisenes õige asjaga mäng läheb järgmisele tasemele

		game.pc.append(game.current_level[game.status])    #Kotis olev komponent lisatakse olemasolevale seadmete listile
		
		componentInfo.get_node("label").text = partText[game.bag]	# Toodud komponendi kohta õpetlik info 
		componentInfo.visible = true
		staapmessage.visible = false
#		if game.status == 7:
#			game.status = 0
#			game.level = 2
		game.status = game.status +1 	# Mäng astme võrra edasi
		if game.bag == "Keyboard":
			mother.bag="OS"
		if game.bag == "Mouse":
			mother.bag="Game"
		staapmessage.get_node("label").text = staapText[game.current_level[game.status]]	
	else:
	

		staapmessage.visible = true
	
		
	
		
	
	
	_on_Partinfo_renewlist()

	
func _on_Exit_pressed():
	self.get_node("Exit").visible = false
	for _i in self.get_children ():
		_i.visible = false
	get_tree().paused = false
	staapmessage.visible = false
	game.bag = "empty"
#	intheBag.visible = true
	






func _on_ok_pressed():
	staapmessage.get_node("label").text = staapText[game.current_level[game.status+1]]
	game.pc.append(game.current_level[game.status])
	game.status = game.status +1
	if game.ok_button_l1[game.status] == 0:
		self.get_node("StaapText/ok").visible = 	false
	





func _on_Partinfo_renewlist():
	if game.level == 1:
		get_tree().set_group("level1_label", "visible", true)
	if game.level == 2:
		get_tree().set_group("level2_label", "visible", true)
	
	print("jupid ",game.pc)
	for i in game.pc:
		get_node(i+"_label").modulate.a = 1


func _on_Level1_end_finished():
		print("levelivahetus")
		level1end.visible = false
		var levelanime = get_parent().get_node("Level_end/Nextlevelanimation")
		var levelscreen = get_parent().get_node("Level_end")
		levelscreen.visible = true
		levelanime.play("Nextlevel")
		
		
		


func _on_Nextlevelanimation_animation_finished(anim_name):
		print("levelivahetus_lõpp")
		if anim_name == "Nextlevel":
			var levelscreen = get_parent().get_node("Level_end")
			levelscreen.visible = false
			emit_signal("levelup")
