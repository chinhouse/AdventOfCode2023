data = file.readLines("input.txt")

N = [-1, 0]; S = [1, 0]; W = [0, -1]; E = [0, 1]
moves = {["|", S] : S,
         ["|", N] : N,
         ["-", E] : E,
         ["-", W] : W,
         ["L", W] : N,
         ["L", S] : E,
         ["J", E] : N,
         ["J", S] : W,
         ["7", E] : S,
         ["7", N] : W,
         ["F", W] : S,
         ["F", N] : E}

getStart = function()
	for i in range(0, data.len - 1)
		for j in range(0, data[0].len - 1)
			if data[i][j] == "S" then return [i, j]
		end for
	end for
end function

startOrientation = function(s)
	height = data.len; width = data[0].len
	dirs = [["|7F", N], ["|LJ", S], ["-FL", W], ["-J7", E]]
	for dir in dirs
		row = dir[1][0] + s[0]
		col = dir[1][1] + s[1]
		if 0 <= row < height and 0 <= col < width and dir[0].indexOf(data[row][col]) != null then
			if dir[1][0] then return ["|", dir[1]]
			return ["-", dir[1]]
		end if
	end for
end function

findPath = function()
	start = getStart
	row = start[0]; col = start[1]
	x = startOrientation(start)
	cur = x[0]; dir = x[1]
	results = [start]
	while true
		dir = moves[[cur, dir]]
		dr = dir[0]; dc = dir[1]
		row += dr
		col += dc
		if [row,col] == start then break
		cur = data[row][col]
		results.push([row, col])
	end while
	return results
end function

shoelace = function(points)
	res = 0
	n = points.len
	for i in range(0, n - 1)
		p1 = points[i]
		p2 = points[(i + 1) % n]
		x1 = p1[0]; y1 = p1[1]
		x2 = p2[0]; y2 = p2[1]
		res += x1 * y2 - x2 * y1
	end for
	return abs(res) / 2
end function

results = findPath
print results.len / 2
print shoelace(results) - results.len / 2 + 1