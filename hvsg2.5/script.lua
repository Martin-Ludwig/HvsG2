schwarz=Color.new(0,0,0)
weiss=Color.new(255,255,255)

alpha= 255
alpha2= 255
alpha3= 255
start= nil
blinken= nil
load=true
while true do
screen:clear(Color.new(alpha,alpha,alpha))
pad = Controls.read()

if start then
	if alpha >= -50 then
		alpha= alpha - 5
	end
	if alpha <= -50 then
		if alpha2 >= -50 then
			alpha2= alpha2 - 5
		end
	end
	if alpha2 <= -50 then
		dofile("index.lua")
	end
	if alpha3 >= 0 then
		alpha3= alpha3 - 15
	end
else
	if alpha3 > 254 then
		blinken= true
	end 
	if alpha3 < 1 then
		blinken= false
	end
	if blinken then
		alpha3= alpha3 - 15
	end
	if not blinken then
		alpha3= alpha3 + 15
	end
end

screen:print(200,137,"Start!",Color.new(alpha3,alpha3,alpha3))
screen:fillRect(160, 30, 150, 30,Color.new(alpha2,alpha2,alpha2))
screen:print(170,40,"Held vs Gegner 2!",schwarz)
if not load then
	if pad:cross() and pad~=oldpad or pad:start() and pad~=oldpad then
		start= true
	end
end
oldpad = pad
screen.flip()
screen.waitVblankStart()
load= false
end