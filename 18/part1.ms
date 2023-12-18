import "listUtil"
if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

// begin part 1
directions = {"U": [0, -1], "D": [0, 1], "L": [-1,0], "R": [1, 0]}

curPos = [0,0]
positions = [curPos]
sum1 = 0; sum2 = 0
perimeter = 0
for line in data
	line = line.split(" ")
	direction = line[0]
	distance = line[1].val
	perimeter += distance
	delta = directions[direction].times(distance)
	pos = curPos[:]
	curPos = [pos[0] + delta[0], pos[1] + delta[1]]
	positions.push(curPos)
end for
A = 0;B=0
for i in positions.indexes
	A += positions[i-1][0] * positions[i][1]
	B += positions[i-1][1] * positions[i][0]
end for
print "Part 1: " + ((abs(A-B) + perimeter)/2 + 1)

// begin part 2
directions = {"3": [0, -1], "1": [0, 1], "2": [-1,0], "0": [1, 0]}

hextodec = function(h)
	hexdigits = "0123456789abcdef".split("")
	res = 0
	for hd in h.split("")
		res = res * 16 + hexdigits.indexOf(hd)
	end for
	return res
end function

curPos = [0,0]
positions = [curPos]
sum1 = 0; sum2 = 0
perimeter = 0
for line in data
	line = line.split(" ")
	direction = line[2][-2]
	distance = hextodec(line[2][2:-2])
	
	perimeter += distance
	delta = directions[direction].times(distance)
	pos = curPos[:]
	curPos = [pos[0] + delta[0], pos[1] + delta[1]]
	positions.push(curPos)
end for
res = 0
for i in positions.indexes
	res += positions[i-1][0] * positions[i][1]
	res -= positions[i-1][1] * positions[i][0]
end for
print "Part 2: " +(((abs(res) + perimeter)/2)+1)