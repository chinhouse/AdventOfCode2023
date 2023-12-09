import "listUtil"
if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

findNextNum = function(seq)
	lastNum = seq[-1]
	diff = []
	while seq.distinct != [0]
		seq = calcDiff(seq)
		diff.push(seq)
	end while
	
	return calcNextNum(diff)+lastNum
end function

calcDiff = function(seq)
	newDiff = []
	for i in range(0, seq.len - 2)
		newDiff.push(seq[i+1] - seq[i])
	end for
	return newDiff
end function

calcNextNum = function(diff)
	res = 0
	for d in diff
		res += d[-1]
	end for
	return res
end function

sum = 0
for line in data
	seq = line.split(" ")
	seq.apply(@val)
	sum += findNextNum(seq)
end for
print sum