data = file.readLines("input.txt")

digits = {}	
wordNums = "one two three four five six seven eight nine".split
for i in range(1, wordNums.len)
	digits[wordNums[i-1]] = i
	digits[str(i)] = i
end for

getNumber = function(s)
	return getDigit(s) * 10 + getDigit(s, true)
end function

getDigit = function(s, rev=false)
	if rev then
		for i in range(0, s.len-1)
			for d in digits.indexes
				if d == s[s.len-d.len - i:s.len-i] then return digits[d]
			end for
		end for
	else
		for i in range(0, s.len-1)
			for d in digits.indexes
				if d == s[i:d.len+i] then return digits[d]
			end for
		end for
	end if
	return 0
end function

sum = 0
for line in data
	sum += getNumber(line)
end for
print "Day 1, part 2: " + sum