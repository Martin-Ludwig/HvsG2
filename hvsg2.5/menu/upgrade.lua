select=1
load= true

function update()
upgrades=
{
{name="Angriff "..((ang_buff-1)*100).."%",buff= ang_buff, max_buff=1.25, tp_kosten= math.floor(25*math.pow(ang_buff,10)), ep_kosten= math.floor(0*math.pow(ang_buff,4))},
{name="Leben   "..((hp_buff-1)*100).."%",buff= hp_buff, max_buff=1.25, tp_kosten= math.floor(25*math.pow(hp_buff,10)), ep_kosten= math.floor(0*math.pow(hp_buff,4))},
{name="Tempo   "..((1-tempo_buff)*100).."%",buff= tempo_buff , max_buff=0.75, tp_kosten= math.floor(25*math.pow((1-tempo_buff+1),10)), ep_kosten= math.floor(0*math.pow(tempo_buff,-3))},
{name="Heilung "..((heil_buff-1)*100).."%",buff= heil_buff, max_buff= 1.25,tp_kosten= math.floor(25*math.pow(heil_buff,10)), ep_kosten= math.floor(0*math.pow(heil_buff,4))},
{name="Schutz  "..held_def, max_buff=3,buff= held_def , tp_kosten= 300+held_def*150, ep_kosten= 0+held_def*0},
}
farbe_init(upgrades,255,255,255)
end
update()


while true do
screen:clear()
pad = Controls.read()

screen:blit(430,3,dreieck,false) screen:print(438,1,":Menu",weiss)
screen:print(1,1,"Upgrade",gelb)
screen:fillRect(10, 10, 155, 18+(table.getn(upgrades)*10), grau)
screen:fillRect(190, 10, 150, 45, d_grau)
for k, n in pairs(upgrades) do
	if select == k then
		farbe(upgrades,k,0,255,0,10)
		screen:print(25, 10+k*10, n.name, menufarbe)
		screen:print(200, 20, n.name, gruen)
		if upgrades[select].buff ~= upgrades[select].max_buff then
			if (ep - (upgrades[select].ep_kosten)) >= 0 then
				screen:print(205, 30, "Ep Kosten "..upgrades[select].ep_kosten.." Ep", weiss)
			else
				screen:print(205, 30, "Ep Kosten "..upgrades[select].ep_kosten.." Ep", rot)
			end
			if (tp - (upgrades[select].tp_kosten)) >= 0 then
				screen:print(205, 40, "Tp Kosten "..upgrades[select].tp_kosten.." Tp", weiss)
			else
				screen:print(205, 40, "Tp Kosten "..upgrades[select].tp_kosten.." Tp", rot)
			end
		else
			screen:print(205,30,"Voll ausgebaut!",weiss)
		end
	else
		farbe(upgrades,k,255,255,255,5)
		screen:print(25, 10+k*10, n.name, menufarbe)
	end
end

screen:fillRect(190, 60, 150, 45, d_grau)
screen:print(200,70,"Held",gruen)
screen:print(205,80,"Ep: "..ep, weiss)
screen:print(205,90,"Tp: "..tp, weiss)

if not load then
	if pad:triangle() and pad~=oldpad then
		dofile("index.lua")
	end
	
	if pad:down() and pad~=oldpad and (select < table.getn(upgrades)) then
		select= select+1
	end

	if pad:up() and pad~=oldpad and select > 1 then
		select= select-1
	end
	
	if pad:cross() and pad~=oldpad and (tp - (upgrades[select].tp_kosten)) >= 0 and (ep - (upgrades[select].ep_kosten)) >= 0 then
		if select==1 and ang_buff < upgrades[1].max_buff then --angriff
			ang_buff= ang_buff + 0.01
			tp= tp - upgrades[select].tp_kosten
			ep= ep - upgrades[select].ep_kosten
		end
		if select==2 and hp_buff < upgrades[2].max_buff then --leben
			hp_buff= hp_buff + 0.01
			tp= tp - upgrades[select].tp_kosten
			ep= ep - upgrades[select].ep_kosten
		end
		if select==3 and tempo_buff > upgrades[3].max_buff then --tempo
			tempo_buff= tempo_buff - 0.01
			tp= tp - upgrades[select].tp_kosten
			ep= ep - upgrades[select].ep_kosten
		end
		if select==4 and heil_buff < upgrades[4].max_buff then --heilung
			heil_buff= heil_buff + 0.01
			tp= tp - upgrades[select].tp_kosten
			ep= ep - upgrades[select].ep_kosten
		end		
		if select==5 and held_def < upgrades[5].max_buff then --schutz
			held_def= held_def + 1
			tp= tp - upgrades[select].tp_kosten
			ep= ep - upgrades[select].ep_kosten
		end
		save_daten()
		load_daten()
		update()
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.5",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end