import "listUtil"
cache = {}

calculate = function(pattern, counts)
	idx = pattern+counts.join(",")
	if not pattern then 
		val = counts.len == 0
		if not cache.hasIndex(idx) then
			cache[idx] = val
		end if
		return cache[idx]
	end if
	
	if not counts then
		val = pattern.indexOf("#") == null
		if not cache.hasIndex(idx) then
			cache[idx] = val
		end if
		
		return cache[idx]
	end if
	
	result = 0
	
	p = ".?".indexOf(pattern[0])
	if p != null then 
		idx = pattern[1:]+counts.join(",")
		if not cache.hasIndex(idx) then
			val = calculate(pattern[1:],counts)
			cache[idx] = val
		end if
		result += cache[idx]
	end if
	
	p = "#?".indexOf(pattern[0])
	if p != null and counts[0]<= pattern.len and pattern[:counts[0]].indexOf(".") == null and (counts[0] == pattern.len or pattern[counts[0]] != "#") then
		idx = pattern[counts[0]+1:]+counts[1:].join(",")
		if not cache.hasIndex(idx) then
			val = calculate(pattern[counts[0]+1:],counts[1:])
			cache[idx]=val
		end if
		result += cache[idx]
	end if
	
	return result
end function

duplicate = function(s, n, delim)
	s = [s]*n
	s = s.join(delim)
	return s
end function

if 1 then fn = "input.txt" else fn = "sample.txt" 
data = file.readLines(fn)
if not data[-1] then data.pop

nums = [1,5]
for i in [0, 1]
	tt = time
	sum = 0
	for line in data
		line = line.split(" ")
		pattern = duplicate(line[0], nums[i], "?")
		counts = duplicate(line[1], nums[i], ",").split(",")
		counts.apply(@val)
		sum += calculate(pattern, counts)
	end for
	print "Day 12, part " + (i + 1) + ": " + sum
	print "Took " + (time - tt) + " seconds"
end for

