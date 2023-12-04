data = file.readLines("input.txt")
if not data[-1] then data.pop

getGameRGB = function(s)
	game = s.split(":")
	gameID = game[0].split(" ")[1].val
	mred = 0
	mgreen = 0
	mblue = 0
	RGBs = game[1].split(";")
	for RGB in RGBs
		RGB = RGB.split(" ")
		for i in range(0, RGB.len - 1)
			pv = RGB[i].val
			if pv then
				color = RGB[i+1]
				if color[:3] == "red" and pv > mred then mred = pv
				if color[:5] == "green" and pv > mgreen then mgreen = pv
				if color[:4] == "blue" and pv > mblue then mblue = pv
			end if
		end for
	end for
	return [gameID, mred, mgreen, mblue]
end function

sum = 0
for line in data
	info = getGameRGB(line)
	if info[1] <= 12 and info[2] <= 13 and info[3] <= 14 then sum += info[0]
end for
print "Day 2, part 1: " + sum

sum = 0 
for line in data
	info = getGameRGB(line)
	sum += info[1]*info[2]*info[3]
end for
print "Day 2, part 2: " + sum