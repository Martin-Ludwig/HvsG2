function newgame()
	ebene = 1
	erfahrung = 0
	allep = 0
	epstop = 1
	held_stufe = 1
	
	gegner_angriff=false
	gegner_ang_zeit= 0
	gegner_vampirbiss=false
	gegner_vamp_zeit= 0
	gegner_toxin=false
	gegner_tox_zeit= 0
	gegner_toxin_wirkung=false
	gegner_toxin_wirkzeit=0
	gegner_kraft= 5

--Held Werte

	held_maxleben= math.floor((100+(held_stufe-1)*10)*hp_buff)
	held_leben= held_maxleben
	held_dmg_min= math.floor((8+(held_stufe-1)*2)*ang_buff)
	held_dmg_max= math.floor((11+(held_stufe-1)*2)*ang_buff)
	held_heilkraft=  math.floor(held_maxleben*(0.48+((heil_buff-1)/2)))/held_maxleben

	held_ang= math.floor(30*tempo_buff)
	held_heil= math.floor(60*tempo_buff)
	held_vamp= math.floor(50*tempo_buff)
	held_tox= math.floor(50*tempo_buff)
	kraft_reserve_maxzeit= 100
	bluttrinker_maxzeit= 100
	panik_maxzeit= 100
	genesung_maxzeit= 100
	vergeltung_maxzeit= 100

	held_kraft= 5
	held_letzter_dmg= 0

	held_angriff=false
	held_heilung=false
	held_vampirbiss=false
	held_toxin=false
	held_toxin_wirkung=false
	
	elite_kraft_reserve=false
	elite_bluttrinker=false
	elite_panik=false
	elite_genesung=false
	elite_vergeltung=false
	
	elite_cooldown= 0
	elite_maxzeit= math.floor(750*tempo_buff)
end

function newgegner()
	if dungeon=="grune Wiese" then
		grune_wiese()
	elseif dungeon=="blaue Wiese" then
		blaue_wiese()
	elseif dungeon=="schwarze Wiese" then
		schwarze_wiese()
	elseif dungeon=="Jungle" then
		jungle()
	elseif dungeon=="Banditen Lager" then
		banditen_lager()
	elseif dungeon=="Pirateninsel" then
		pirateninsel()
	elseif dungeon=="Atlantis" then
		atlantis()
	elseif dungeon=="Inferno" then
		inferno()
	elseif dungeon=="Friedhof" then
		friedhof()
	elseif dungeon=="Unterwelt" then
		unterwelt()
	elseif dungeon=="Fabrik" then
		fabrik()
	elseif dungeon=="Exil" then
		exil()
	elseif dungeon=="testdungeon" then
		testdungeon()
	end
	
	gegner_maxleben= math.floor(gegner_maxleben * gegnerbuff_hp)
	gegner_dmg_min= math.floor(gegner_dmg_min * gegnerbuff_ang)
	gegner_dmg_max= math.floor(gegner_dmg_max * gegnerbuff_ang)
	gegner_ang= math.floor(gegner_ang * gegnerbuff_tempo)
	gegner_vamp= math.floor(gegner_vamp * gegnerbuff_tempo)
	gegner_tox= math.floor(gegner_tox * gegnerbuff_tempo)
	
	gegner_leben= gegner_maxleben
	gegner_letzter_dmg= 0
	gegner_kraft= 5
end

function newebene()
	ebene = ebene + 1
	epstop=1
	held_letzter_dmg=0
	held_toxin_wirkung=false
	held_maxleben= math.floor((100+(held_stufe-1)*10)*hp_buff)
	held_dmg_min= math.floor((8+(held_stufe-1)*2)*ang_buff)
	held_dmg_max= math.floor((11+(held_stufe-1)*2)*ang_buff)
	held_heilkraft=  math.floor(held_maxleben*(0.48+((heil_buff-1)/2)))/held_maxleben
	maxleben()
end

function maxleben()
	if 	held_leben > held_maxleben then
		held_leben = held_maxleben
	end
	if 	gegner_leben > gegner_maxleben then
		gegner_leben = gegner_maxleben
	end	
end
function letzter_dmg()
	if held_letzter_dmg<1 then
		screen:print(295,175,held_letzter_dmg,gelb)
		else
		screen:print(295,175,"+"..held_letzter_dmg,gelb)
	end
	if gegner_letzter_dmg<1 then
		screen:print(295,99,gegner_letzter_dmg,gelb)
		else
		screen:print(295,99,"+"..gegner_letzter_dmg,gelb)
	end
end

----Aktionen----
--Held--
function Held_Ladebalken()
	screen:drawLine(190,120,held_ladebalken+190,120,weiss)
	screen:drawLine(190,121,290,121,grau)  --länge
	screen:drawLine(290,120,290,121,grau)  --seite
end
function Gegner_Ladebalken()
	screen:drawLine(190,196,gegner_ladebalken+190,196,weiss)
	screen:drawLine(190,197,290,197,grau)  --länge
	screen:drawLine(290,197,290,196,grau)  --seite
end

function Held_Angriff()
	held_ang_zeit= held_ang_zeit + 1
	if held_ang_zeit >= held_ang then
		gegner_leben = gegner_leben - held_dmg
		held_letzter_dmg= held_dmg/(-1)
		held_kraft= held_kraft + 1
		held_angriff= false
	end
	screen:print(190,110,"Angriff",weiss)
end

function Held_Heilung()
	held_heil_zeit= held_heil_zeit + 1
	if held_heil_zeit >= held_heil then
		held_leben= held_leben + math.floor(held_heilkraft*held_maxleben)
		gegner_letzter_dmg= math.floor(held_heilkraft*held_maxleben)
		maxleben()
		held_kraft= held_kraft - 3
		held_heilung= false
	end
	screen:print(190,110,"Heilung",weiss)
end

function Held_Vamp()
	held_vamp_zeit= held_vamp_zeit + 1
	if held_vamp_zeit >= held_vamp then
		held_leben= held_leben + math.floor(held_dmg*(1.5+held_heilkraft))
		gegner_letzter_dmg= math.floor(held_dmg*(1.5+held_heilkraft))
		maxleben()
		gegner_leben= gegner_leben - math.floor(held_dmg*1.5)
		held_letzter_dmg= math.floor(held_dmg*1.5)/(-1)
		held_kraft= held_kraft - 3
		held_vampirbiss= false
	end
	screen:print(190,110,"Vampirbiss",weiss)
end

function Held_Tox()
	held_tox_zeit= held_tox_zeit + 1
	if held_tox_zeit >= held_tox then
		gegner_leben = gegner_leben - held_dmg
		held_letzter_dmg= held_dmg/(-1)
		wirkte= 1
		held_kraft= held_kraft - 3
		held_toxin_wirkzeit= 0
		held_toxin_wirkung=true
		held_toxin= false
	end
	screen:print(190,110,"Toxin",weiss)
end

function Held_Tox_Wirkung()
	held_toxin_wirkzeit= held_toxin_wirkzeit + 1
	if  held_toxin_wirkzeit >= 150 then
		wirkte= 0
		held_toxin_wirkung=false
	elseif held_toxin_wirkzeit == 50+(wirkte-1)*50 then
		gegner_leben = gegner_leben - held_dmg
		held_letzter_dmg= held_dmg/(-1)
		wirkte= wirkte+1
	end
end

function Vergeltung()
	if elite_vergeltung then
		gegner_leben= gegner_leben - math.ceil(gegner_dmg*(ang_buff+((ang_buff-1)*2)))
		held_letzter_dmg=math.ceil(gegner_dmg*(ang_buff+((ang_buff-1)*2))/(-1))
	end
end

--Gegner--

function Gegner_Angriff()
	gegner_ang_zeit= gegner_ang_zeit + 1
	if gegner_ang_zeit >= gegner_ang then
		held_leben = held_leben - gegner_dmg
		gegner_letzter_dmg= gegner_dmg/(-1)
		Vergeltung()
		gegner_kraft= gegner_kraft + 1
		gegner_ang_zeit= 0
		gegner_angriff= false
	end
	screen:print(190,186,"Angriff",weiss)
end

function Gegner_Vampirbiss()
	gegner_vamp_zeit= gegner_vamp_zeit + 1
	if gegner_vamp_zeit >= gegner_vamp then
		held_leben= held_leben - gegner_dmg 
		gegner_letzter_dmg= gegner_dmg/(-1)
		gegner_leben= gegner_leben + gegner_dmg*2
		held_letzter_dmg= gegner_dmg*2
		Vergeltung()
		maxleben()
		gegner_kraft= gegner_kraft - 3
		gegner_vamp_zeit= 0
		gegner_vampirbiss= false
	end
	screen:print(190,186,"Vampirbiss",weiss)
end

function Gegner_Toxin()
	gegner_tox_zeit= gegner_tox_zeit + 1
	if gegner_tox_zeit >= gegner_tox then
		gegner_kraft= gegner_kraft - 3
		held_leben = held_leben - gegner_dmg
		gegner_letzter_dmg= gegner_dmg/(-1)
		Vergeltung()
		wirkte_gegner= 1
		gegner_toxin_wirkzeit= 0
		gegner_toxin_wirkung=true
		gegner_tox_zeit= 0
		gegner_toxin= false
	end
	screen:print(190,186,"Toxin",weiss)
end

function Gegner_Toxin_Wirkung()
	gegner_toxin_wirkzeit= gegner_toxin_wirkzeit + 1
	if gegner_toxin_wirkzeit >= 150 then
		wirkte_gegner= 0
		gegner_toxin_wirkung=false
	elseif gegner_toxin_wirkzeit == 50+(wirkte_gegner-1)*50 then
		held_leben = held_leben - gegner_dmg
		gegner_letzter_dmg= gegner_dmg/(-1)
		Vergeltung()
		wirkte_gegner= wirkte_gegner+1
	end
end	

function zeilenumbruch(x,y,farbe)
	for i=1, table.getn(text) do
		screen:print(x,y,text[i],farbe)
		y= y+10
	end
end

function farbe_init(table_,r,g,b)
	for i=1,table.getn(table_) do
		table_[i].r= r
		table_[i].g= g
		table_[i].b= b
	end
end

function farbe(table_,k,r,g,b,farbtempo)
	if table_[k].r > r then
		table_[k].r= table_[k].r - farbtempo
		else
		table_[k].r= table_[k].r + farbtempo
	end
	if table_[k].g > g then
		table_[k].g= table_[k].g - farbtempo
		else
		table_[k].g= table_[k].g + farbtempo
	end
	if table_[k].b > b then
		table_[k].b= table_[k].b - farbtempo
		else
		table_[k].b= table_[k].b + farbtempo
	end
	menufarbe= Color.new(table_[k].r, table_[k].g, table_[k].b)
end
	
	
function load_daten()
	i=1
	twert = {}
	datei = io.open("variablen/daten.txt","r")
	for line in datei:lines() do
		length = string.len(line)
		trim = string.find(line, "=")
		wert = string.sub(line,(trim+2),(length))
		twert[i] = (wert + 0)
		i=i+1
	end
	datei:close()
	elite = twert[1]
	ep = twert[2]
	tp = twert[3]
	hp_buff = twert[4]
	ang_buff = twert[5]
	heil_buff = twert[6]
	held_def = twert[7]
	tempo_buff= twert[8]
	rang= twert[9]
	rang_ep= twert[10]
	fraktal_stufe= twert[11]
	botlvl= twert[12]
end

function save_daten()
	tvar= { "elite = "..elite,
			"ep = "..ep,
			"tp = "..tp,
			"hp_buff = "..hp_buff,
			"ang_buff = "..ang_buff,
			"heil_buff = "..heil_buff,
			"held_def = "..held_def,
			"tempo_buff = "..tempo_buff,
			"rang = "..rang,
			"rang_ep = "..rang_ep,
			"fraktal_stufe = "..fraktal_stufe,
			"botlvl = "..botlvl,
			}
	datei = io.open("variablen/daten.txt","w")
	datei:write("")
	datei:close()
	datei = io.open("variablen/daten.txt","a+")
	for i=1, table.getn(tvar) do
		datei:write(tvar[i].."\n")
	end
	datei:close()
end