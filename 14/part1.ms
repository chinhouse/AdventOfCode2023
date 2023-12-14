import "listUtil"

if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

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

data = transpose(data)

answer = 0
for line in data
	round = findChar(line, "O")
	cube = [-1] + findChar(line, "#") + [line.len]
	res = []
	for i in range(0, cube.len - 2)
		cnt = findBetween(cube[i:i+2], round)
		if cnt > 0 then
			res += range(cube[i], cube[i] + cnt - 1)
		end if
	end for
	res.apply1(@inverseNum, line.len-1)
	answer += sum(res)
end for
print answer
