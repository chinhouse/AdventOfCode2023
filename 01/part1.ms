import "listUtil"

data = file.readLines("input.txt")

getNumber = function(s)
	return getDigit(s) * 10 + getDigit(s, true)
end function

getDigit = function(s, rev=false)
	s = s[:].split("")
	if rev then s.reverse
	for ch in s
		if "0" <= ch <= "9" then return ch.val
	end for
	return 0
end function

sum = 0
for line in data
	sum += getNumber(line)
end for

print "Day 1, part 1: " + sum