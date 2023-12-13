import "listUtil"

if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

differences = function(s1, s2)
	diff = 0
	for i in s1.indexes
		diff += s1[i] != s2[i]
	end for
	return diff
end function

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

reflectLine = function(block, target = 0)
	for r in range(1, block.len - 1)
		diff = 0
		rows1 = block[:r].reversed
		rows2 = block[r:]
		m = [rows1.len, rows2.len].sort[0] 
		for rr in range(0,m-1)
			diff += differences(rows1[rr], rows2[rr])
		end for
		if diff == target then return r
	end for
	return 0
end function

for isSmudge in [0, 1]
	sum = 0
	blocks = data.join(char(10)).split(char(10)+char(10))
	for block in blocks
		block = block.split(char(10))
		i = reflectLine(block, isSmudge)
		if i != 0 then
			sum += i * 100
		else
			sum += reflectLine(transpose(block), isSmudge)
		end if
	end for
	print "Day 13, part " + (isSmudge + 1) + ": " + sum	
end for