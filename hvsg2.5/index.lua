if elite== nil then
dofile("mob/gegner.lua")
dofile("mob/dungeons.lua")
dofile("funktionen.lua")
load_daten()

dreieck=Image.load("bilder/dreieck.png")
viereck=Image.load("bilder/viereck.png")
average_png= Image.load("bilder/average.png")

schwarz=Color.new(0,0,0)
weiss=Color.new(255,255,255)
rot=Color.new(255,0,0)
gruen=Color.new(0,255,0)
hell_gruen=Color.new(128,255,128)
blau=Color.new(0,0,255)
gelb=Color.new(255,255,0)
orange=Color.new(255,100,0)
grau=Color.new(127,127,127)
d_grau=Color.new(30,30,30)
hellblau=Color.new(100,100,255)
dunkelblau=Color.new(50,50,200)

dungeons=
{
{name="grune Wiese",   ebenen_min=  8, ebenen_max= 12, maxgegner= 4,rang=1 , ep_kosten= 0 , tp_kosten= 0 },
{name="blaue Wiese",   ebenen_min= 12, ebenen_max= 18, maxgegner= 4,rang=2 , ep_kosten= 40, tp_kosten= 0 },
{name="schwarze Wiese",ebenen_min=  4, ebenen_max=  6, maxgegner= 4,rang=5 , ep_kosten= 90, tp_kosten= 0 },
{name="Jungle",        ebenen_min= 15, ebenen_max= 20, maxgegner= 4,rang=2 , ep_kosten= 55, tp_kosten= 0 },
{name="Banditen Lager",ebenen_min= 15, ebenen_max= 20, maxgegner= 4,rang=3 , ep_kosten= 50, tp_kosten= 0 },
{name="Pirateninsel",  ebenen_min= 17, ebenen_max= 21, maxgegner= 6,rang=3 , ep_kosten= 60, tp_kosten= 0 },
{name="Atlantis",      ebenen_min= 18, ebenen_max= 22, maxgegner= 4,rang=4 , ep_kosten= 70, tp_kosten= 0 },
{name="Inferno",       ebenen_min= 18, ebenen_max= 22, maxgegner= 4,rang=4 , ep_kosten= 60, tp_kosten= 0 },
{name="Friedhof",      ebenen_min= 20, ebenen_max= 24, maxgegner= 6,rang=5 , ep_kosten= 80, tp_kosten= 0 },
{name="Unterwelt",     ebenen_min= 20, ebenen_max= 28, maxgegner= 5,rang=6 , ep_kosten= 80, tp_kosten= 0 },
{name="Fabrik",        ebenen_min= 24, ebenen_max= 30, maxgegner= 5,rang=6 , ep_kosten= 80, tp_kosten= 0 },
{name="Exil",          ebenen_min=  5, ebenen_max=  8, maxgegner= 5,rang=7 , ep_kosten= 120, tp_kosten= 0 },
}
end

fertigkeiten= {"keine Elite","Kraft reserve","Panik","Genesung","Bluttrinker","Vergeltung"}

auswahl=
{
{name="Dungeons"},
{name="Fraktale"},
{name="Elite"},
{name="Upgrade"},
{name="Daten vernichten"},
}

farbe_init(auswahl,255,255,255)

epkosten= 150
tpkosten= 0
fraktale={
	{name="blaue Wiese", maxgegner= 4},
	{name="Jungle", maxgegner= 4},
	{name="Banditen Lager", maxgegner= 4},
	{name="Pirateninsel", maxgegner= 6},
	{name="Atlantis", maxgegner= 4},
	{name="Inferno", maxgegner= 4},
	{name="Friedhof", maxgegner= 6},
	{name="Unterwelt", maxgegner= 5},
	{name="Fabrik", maxgegner= 5},
}

text={"Ep: "..ep,"Tp: "..tp,"","Elite: "..fertigkeiten[elite],"",
		"Angriff "..((ang_buff-1)*100).."%",
		"Leben   "..((hp_buff-1)*100).."%",
		"Tempo   "..((1-tempo_buff)*100).."%",
		"Heilung "..((heil_buff-1)*100).."%",
		"Schutz  "..held_def,
}

if rang > 8 then
	rang_next_stufe= 1050
	else
	rang_next_stufe= (150+((rang-1)*125))
end

fraktal_mode=false
select=1
load= true
while true do
screen:clear()
pad = Controls.read()

fraktal_dungeon= math.random(1,table.getn(fraktale))
gegnerwahl= math.random(2,fraktale[fraktal_dungeon].maxgegner)

screen:print(1,1,"Menu",gelb)
screen:fillRect(10, 10, 155, 18+(table.getn(auswahl)*10), grau)

--Held stats
screen:fillRect(190, 10, 175, 170, d_grau)
zeilenumbruch(200,40,weiss)
screen:print(200,20,"Held",gruen)
screen:print(200,150,"Rang "..rang,weiss)
rang_ep_balken= ((rang_ep/rang_next_stufe)*100)*(110/100)
screen:fillRect(200, 160, rang_ep_balken, 3, hellblau)
screen:drawLine(200, 162, 310, 162,weiss)
screen:print(200,165,rang_ep.."/"..rang_next_stufe,weiss)
	
if auswahl[select].name=="Fraktale" then
	screen:fillRect(190, 185, 175, 70, d_grau)
	screen:print(200, 190, "Fraktale "..fraktal_stufe, gruen)
	screen:print(205, 205, "Ebenen 20", weiss)
	if rang >= math.ceil(fraktal_stufe/2) then
		screen:print(205, 215, "Rang "..math.ceil(fraktal_stufe/2), weiss)
	else
		screen:print(205, 215, "Rang "..math.ceil(fraktal_stufe/2), rot)
	end
	if (ep - epkosten) >= 0 then
		screen:print(205, 225, "Ep Kosten "..epkosten, weiss)
	else
		screen:print(205, 225, "Ep Kosten "..epkosten, rot)
	end
	if (tp - tpkosten) >= 0 then
		screen:print(205, 235, "Tp Kosten "..tpkosten, grau)
	else
		screen:print(205, 235, "Tp Kosten "..tpkosten, rot)	
	end		
end

for k, n in pairs(auswahl) do
	if select == k then
		farbe(auswahl,k,0,255,0,10)
		screen:print(25, 10+k*10, n.name, menufarbe)
	else
		farbe(auswahl,k,255,255,255,5)
		screen:print(25, 10+k*10, n.name, menufarbe)
	end
end

if not load then
	if pad:down() and pad~=oldpad and (select < table.getn(auswahl)) then
		select= select+1
	end

	if pad:up() and pad~=oldpad and select > 1 then
		select= select-1
	end
	
	if auswahl[select].name=="Dungeons" and pad:cross() and pad~=oldpad then
		dofile("menu/dungeon.lua")
	end
	
	if auswahl[select].name=="Fraktale" and (ep - epkosten) >= epkosten and (tp - tpkosten) >= tpkosten and rang >= math.ceil(fraktal_stufe/2) and pad:cross() and pad~=oldpad then
		fraktal_mode=true
		
		fraktal_dungeon= math.random(1,table.getn(fraktale))
		dungeon= fraktale[fraktal_dungeon].name
		ebenen= 20
		bossebene = ebenen
		gegnerwahl= math.random(2,fraktale[fraktal_dungeon].maxgegner)	
		maxgegner= fraktale[fraktal_dungeon].maxgegner
		
		gegnerbuff_ang= 1+((fraktal_stufe-1)/100)
		gegnerbuff_hp= 1+((fraktal_stufe-1)/100)
		gegnerbuff_tempo= 1-((fraktal_stufe-1)/100)

		ep= ep - epkosten
		tp= tp - tpkosten

		save_daten()
		dofile("menu/kampf.lua")
	end
	
	if auswahl[select].name=="Elite" and pad:cross() and pad~=oldpad then
		dofile("menu/elite.lua")
	end
	
	if auswahl[select].name=="Upgrade" and pad:cross() and pad~=oldpad then
		dofile("menu/upgrade.lua")
	end
	
	if auswahl[select].name=="Daten vernichten" and pad:cross() and pad~=oldpad then
		dofile("menu/daten.lua")
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.5",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end