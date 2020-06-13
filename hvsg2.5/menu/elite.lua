
fertigkeiten=
{
{elite_name= "keine Elite", info="Ohne Elite spielen.",info2="+50% Ep+Tp."},
{elite_name= "Kraft reserve", info="Du bekommst 5 Kraft.",info2=""},
{elite_name= "Panik", info="Gegner wird gestoppt.",info2=""},
{elite_name= "Genesung", info="Heilt.",info2=""}, --25%
{elite_name= "Bluttrinker", info="Stiehlt Leben.",info2=""},
{elite_name= "Vergeltung", info="Reflektiert Schaden.",info2=""},
}

farbe_init(fertigkeiten,255,255,255)

select= 1
load= true
while true do
screen:clear()
pad = Controls.read()

screen:print(1,1,"Elite", gelb)
screen:blit(430,3,dreieck,false) screen:print(438,1,":Menu",weiss)


screen:fillRect(10, 10, 155, 18+(table.getn(fertigkeiten)*10), grau)
screen:fillRect(190, 10, 185, 18+(table.getn(fertigkeiten)*10), d_grau)
for k, n in pairs(fertigkeiten) do
	if select == k then
		farbe(fertigkeiten,k,0,255,0,10)
		screen:print(25, 10+k*10, n.elite_name, menufarbe)
		screen:print(200, 20, n.elite_name, gruen)
		screen:print(205, 30, n.info, weiss)
		screen:print(205, 40, n.info2, weiss)
	elseif k == elite then
		farbe(fertigkeiten,k,0,0,0,5)
		screen:print(25, 10+k*10, n.elite_name, menufarbe)
	else
		farbe(fertigkeiten,k,255,255,255,5)
		screen:print(25, 10+k*10, n.elite_name, menufarbe)
	end
end

if not load then
	if pad:cross() and pad~=oldpad then
		elite= select
		save_daten()
	end
	if pad:triangle() and pad~=oldpad then
		dofile("index.lua")
	end
	if pad:down() and pad~=oldpad and (select < table.getn(fertigkeiten)) then
		select= select+1
	end
	if pad:up() and pad~=oldpad and select > 1 then
		select= select-1
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.5",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end