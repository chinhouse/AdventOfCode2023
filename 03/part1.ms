grid = file.readLines("input.txt")
if not grid[-1] then grid.pop

height = grid.len
width = grid[0].len

results = []
gears = {}

getSurroundingPoints = function(points)
	deltas = [[-1,-1],[0,-1],[1,-1],
	          [-1, 0],       [1,0],
	          [-1, 1],[0, 1],[1,1]]
	surrPoints = {}
	for point in points
		for delta in deltas
			x = point[0] + delta[0]
			y = point[1] + delta[1]
			if (0 <= x < width) and (0 <= y < height) then
				newPoint = [x,y]
				if points.indexOf(newPoint) == null then
					surrPoints[newPoint] = 1
				end if
			end if
		end for
	end for
	return surrPoints.indexes
end function

hasSpecial = function(points, numCh)
	cnt = 0
	for point in points
		x = point[0]; y = point[1]
		ch = grid[y][x]
		if "0123456789.".indexOf(ch) == null then
			cnt = cnt + 1
		end if
		
		if ch == "*" then
			if gears.hasIndex([x, y]) then
				gears[[x,y]].push(numCh.val)
			else
				gears[[x,y]] = [numCh.val]
			end if
		end if
	end for
	return cnt
end function

sum = 0
sum1 = 0
for y in range(0, height - 1)
	x = 0
	numCh = ""
	points = []
	while x < width
		ch = grid[y][x]
		if "0" <=  ch <= "9" then
			numCh += ch
			points.push([x,y])
		end if
		if numCh != "" and (("0123456789".indexOf(ch) == null) or x == width - 1) then
			surrounding = getSurroundingPoints(points)
			sum1 += numCh.val
			if hasSpecial(surrounding, numCh) then
				sum += numCh.val
			end if
			numCh = ""
			points = []
		end if
		x += 1
	end while
end for
print "Day 3, part 1: " + sum

sum = 0
for gear in gears
	g = gear.value
	if g.len == 2 then
		sum += g[0]*g[1]
	end if
end for
print "Day 3, part 2: " + sum