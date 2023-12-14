import "listUtil"

if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

for i in data.indexes
	data[i] = data[i].split("")
end for

transpose =function(block)
	result = []
	for c in block[0].indexes
		s = ""
		for r in block.indexes
			s += block[r][c]
		end for
		result.push s
	end for
	return result
end function

inverseNum = function(n1, n2)
	return n2 - n1
end function

findChar = function(s, ch)
	res = []
	for i in s.indexes
		if s[i] == ch then res.push i
	end for
	return res
end function

findBetween = function(rng, nums)
	cnt = 0
	for num in nums
		cnt += rng[0] < num < rng[1]
	end for
	return cnt
end function

slide = function(data, dir)
	isNW = (dir == "N" or dir == "W")
	isSE = (dir == "S" or dir == "E")
	isNS = (dir == "N" or dir == "S")
	isWE = (dir == "W" or dir == "E")
	
	if isNS then data = transpose(data)
	newData = list.init2d(data.len, data.len, ".")
	answer = 0
	for c in data.indexes
		line = data[c]
		round = findChar(line, "O")
		cube = [-1] + findChar(line, "#") + [line.len]
		roll = []
		for r in range(0, cube.len - 2)
			cnt = findBetween(cube[r:r+2], round)
			if cnt > 0 and isNW then
				roll += range(cube[r]+1, cube[r] + cnt)
			else if cnt >0 and isSE then
				roll += range(cube[r+1]-cnt, cube[r+1]-1)
			end if
		end for
		
		for r in cube[1:-1]
			newData[r][c] = "#"
		end for
		for r in roll
			newData[r][c] = "O"
		end for
	end for
	if isWE then newData = transpose(newData)
	return newData
end function

cycle = function(data)
	for dir in "NWSE".split("")
		data = slide(data,dir)
	end for
	return data
end function

calcLoad = function(data)
	length = data.len
	res = 0
	for r in data.indexes
		cnt = data[r].split("").counts
		if cnt.hasIndex("O") then res += (cnt["O"]) * (length - r)
	end for
	return res
end function

tt = time
cache = {}
i = 0
while i < 10^9
	data = cycle(data)
	if cache.hasIndex(data) then
		delta = i - cache[data]
		timesMore = (10 ^ 9 - i) % delta - 1
		break
	end if
	cache[data] = i
	i += 1
end while

for i in range(1, timesMore)
	data = cycle(data)
end for

print calcLoad(data)
print time - tt