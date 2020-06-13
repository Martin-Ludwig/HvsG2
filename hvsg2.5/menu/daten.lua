
daten=
{
{name="Nein"},
{name="Ja"}
}
farbe_init(daten,0,0,0)
select=1
load=true
while true do
screen:clear()
pad = Controls.read()

screen:print(120,70,"Daten wirklich vernichten ?",rot)

for k, n in pairs(daten) do
	if select == k then
		farbe(daten,k,0,255,0,10)
		screen:print(200, 100+k*10, n.name, menufarbe)
	else
		farbe(daten,k,127,127,127,5)
		screen:print(200, 100+k*10, n.name, grau)
	end
end

if not load then
	if pad:down() and pad~=oldpad and (select < table.getn(daten))then
		select= select+1
	end
	if pad:up() and pad~=oldpad and select > 1 then
		select= select-1
	end

	if select==1 and pad:cross() and pad~=oldpad then
		dofile("index.lua")
	end

	if select==2 and pad:cross() and pad~=oldpad then
		elite = 1
		ep = 0
		tp = 0
		hp_buff = 1
		ang_buff = 1
		heil_buff = 1
		held_def = 0
		tempo_buff = 1
		rang = 1
		rang_ep = 0
		fraktal_stufe= 1
		botlvl= 1
		
		save_daten()
		dofile("script.lua")
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.4",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end