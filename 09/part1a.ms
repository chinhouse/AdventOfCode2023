import "listUtil"
if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop

findNextNum = function(seq)
	lastNum = seq[-1]
	res = 0
	while seq.distinct != [0]
		res += seq[-1]
		seq = calcDiff(seq)
	end while
	
	return res
end function

calcDiff = function(seq)
	newDiff = []
	for i in range(0, seq.len - 2)
		newDiff.push(seq[i+1] - seq[i])
	end for
	return newDiff
end function

for i in range(1, 2)
	sum = 0
	for line in data
		seq = line.split(" ")
		if i == 2 then seq.reverse
		seq.apply(@val)
		sum += findNextNum(seq)
	end for
	print "Day 9, part " + i + ": " + sum
end for