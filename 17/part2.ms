import "listUtil"
if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

grid = []
for i in data.indexes
	line = data[i].split("")
	line.apply(@val)
	grid.push line
end for

q = []
visited = {}
loss =1

hasVisited = function(x, y, k, dx, dy)
	for i in range(1, k)
		if visited.hasIndex([x, y, i, dx, dy]) then return true
		
	end for
	return false
end function

part2 = function
	m = grid.len
	n = grid[0].len
	directions = [[-1,0],[0,-1],[0,1],[1,0]]
	//heatloss, x, y, length, xdir, ydir, rank (for sort)
	q.push([0,0,0,0,0,1,0])
	q.push([0,0,0,0,1,0,0])
	while q
		info = q.pull
		loss = info[0]
		x = info[1]
		y = info[2]
		k = info[3]
		dx = info[4]
		dy = info[5]
		
		if x == m - 1 and y == n - 1 then
			if k < 4 then
				continue
			end if
			break
		end if
		if visited.hasIndex([x, y, k, dx, dy]) then
			continue
		end if
		visited[[x,y,k,dx,dy]] = 1
		for deltas in directions
			new_dx = deltas[0]
			new_dy = deltas[1]
			straight = (new_dx == dx and new_dy == dy)
			new_x = x + new_dx
			new_y = y + new_dy
			
			if (new_dx == -dx and new_dy == -dy) or (k == 10 and straight) or (k <4 and not straight) or (new_x < 0) or (new_y < 0) or (new_x == m) or (new_y == n) then
				continue
			end if
			
			if straight then
				new_k = k + 1
			else
				new_k = 1
			end if
			new_loss = loss+grid[new_x][new_y]
			rank = new_loss + (m - new_x) + (n - new_y)
			q.push([new_loss, new_x, new_y, new_k, new_dx, new_dy, rank])
		end for
		q.sort(6)
	end while
	return loss
end function
tt = time
print part2
print time - tt