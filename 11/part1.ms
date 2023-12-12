if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

isBetween = function(a, b, c)
	return (a < c < b) or (b < c < a)
end function

combinations = function(elements, comboLength)
	n = elements.len
	if comboLength > n then return []
	
	allCombos = []
	
	genCombos=function(start, currCombo)
		if currCombo.len == comboLength then
			allCombos.push(currCombo)
			return
		end if
		if start == n then return
		for i in range(start, n - 1)
			newCombo = currCombo + [elements[i]]
			genCombos(i + 1, newCombo)
		end for
	end function
	
	genCombos(0, [])
	return allCombos
end function

getGreaterCount = function(arr, n)
	for i in range(0, arr.len - 1)
		if arr[i] > n then return i
	end for
	return arr.len
end function

getPoints = function(data, expansion)
	rows = []
	cols = []
	w = data[0].len
	dots = "."*w
	for i in range(0, data.len - 1)
		line = data[i]
		if line == dots then rows.push(i)
	end for
	for j in range(0, w - 1)
		cnt = 0
		for i in range(0, data.len - 1)
			cnt += data[i][j] == "."
		end for
		if cnt == w then cols.push(j)
	end for
	
	points = []
	for i in range(0, data.len - 1)
		r = getGreaterCount(rows, i)*expansion
		for j in range(0, w - 1)
			c = getGreaterCount(cols, j)*expansion
			if data[i][j] != "." then points.push([r+i,c+j])
		end for
	end for
	return points
end function

distance = function(p1, p2)
	return abs(p1[0]-p2[0]) + abs(p1[1]-p2[1])
end function
ex = [1, 999999]
for i in range(0, 1)
	points = getPoints(data,ex[i])
	pairs = combinations(points, 2)
	
	sum = 0
	for pair in pairs
		sum += distance(pair[0], pair[1])
	end for
	print "Day 11, part " + (i + 1) + ": " + sum
end for