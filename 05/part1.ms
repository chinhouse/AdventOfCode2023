data = file.readLines("input.txt")
if not data[-1] then data.pop

mapAreas = "seed soil fertilizer water light temperature humidity location".split(" ")
instructGroups = {}

getInstructions = function(area51, area52)
	// find the line with the specific instruction heading
	lineNum = 0
	mapTo = [area51, "-to-", area52, " map:"].join("")
	print "Getting instructions for " + mapTo
	while data[lineNum] != mapTo
		lineNum += 1
	end while
	
	instructions = []
	lineNum += 1 // move to next line, which should be the first 1st instruction
	while lineNum < data.len and data[lineNum] != ""
		line = data[lineNum].split(" ")
		dest = line[0].val
		source = line[1].val
		length = line[2].val
		instructions.push([source, dest, length])
		lineNum += 1
	end while
	return instructions
end function

followInstructions = function(mapIx, sourceVal)
	area51 = mapAreas[mapIx]
	area52 = mapAreas[mapIx+1]
	//print "Following instructions from " + area51 + " to " + area52 + " " + sourceVal
	instructions = instructGroups[[area51,area52]]
	foundVal = null
	for instruct in instructions
		startVal = instruct[0]
		destVal = instruct[1]
		length = instruct[2]
		delta = sourceVal - startVal
		if 0 <= delta < length then
			//print sourceVal + " found in " + instruct 
			foundVal = destVal + delta
			break
		end if
	end for	
	if foundVal == null then 
		//print "Not found, so use source: " + sourceVal
		foundVal = sourceVal
	end if
	if area52 == mapAreas[-1] then return foundVal
	return followInstructions(mapIx+1, foundVal)
end function

for i in range(0, mapAreas.len - 2)
	area51 = mapAreas[i]
	area52 = mapAreas[i + 1]
	instructions = getInstructions(area51, area52)
	instructGroups[[area51, area52]] = instructions[:]
end for

seeds = data[0][7:].split(" ")
minimum1 = 14999999999 
for n in seeds
	m = followInstructions(0, n.val)
	if minimum1 > m then minimum1 = m
end for
print "Day 05, part 1: " + minimum1
