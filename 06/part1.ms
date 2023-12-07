import "listUtil"

data = file.readLines("input.txt")
if not data[-1] then data.pop

getBounds = function(n, d)
	discriminant = n * n - 4 * d 
	r1 = (n + sqrt(discriminant)) / 2
	r2 = (n - sqrt(discriminant)) / 2
	
	lowBound = ceil([r1, r2].min)
	uppBound = floor([r1, r2].max)
	if (n - lowBound) * lowBound - d < 1 then lowBound += 1
	if (n - uppBound) * uppBound - d < 1 then uppBound -= 1
	return [lowBound, uppBound]
end function

getNumbers = function(line)
	results = []
	for n in line.split(" ")
		if n.val then results.push(n.val)
	end for
	return results
end function

getNumbersConcat = function(line)
	return [getNumbers(line).join("").val]
end function

getNumWays = function(data, getNumFunc)
	raceTimes = getNumFunc(data[0])
	distances = getNumFunc(data[1])
	
	numOfWays = [0] * raceTimes.len
	for i in range(0, raceTimes.len - 1)
		bounds = getBounds(raceTimes[i], distances[i])
		numOfWays[i] = bounds[1] - bounds[0] + 1
	end for
	return numOfWays
end function

print "Day 6, part 1: " + getNumWays(data, @getNumbers).product
print "Day 6, part 2: " + getNumWays(data, @getNumbersConcat).product
