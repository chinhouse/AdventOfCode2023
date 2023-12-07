import "listUtil"

if 0 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)
if not data[-1] then data.pop
data = data.join(char(13))

data = data.split(char(13) + char(13))
seedInput = data[0][7:].split(" ")
seedInput.apply(@val)
mapBlocks = data[1:]

seedIntervals = []
for i in range(0, seedInput.len - 1, 2)
	start = seedInput[i]; length = seedInput[i+1]
	seedIntervals.push([start, start + length - 1])
end for

for mapBlock in mapBlocks
	print
	print "New map block"
	mappings = mapBlock.split(char(13))[1:]
	newIntervals = []
	while seedIntervals
		interval = seedIntervals.pop
		a = interval[0]; z = interval[1] // a to z
		intervalFound = false
		for mapping in mappings
			mapping = mapping.split(" ")
			mapping.apply(@val)
			dest = mapping[0]
			source = mapping[1]
			length = mapping[2]
			endpoint = source + length - 1
			if source <= a <= z <= endpoint then
				newIntervals.push([a - source + dest, z - source + dest])
				intervalFound = true
				break
			end if
			if source <= a <= endpoint < z then
				newIntervals.push([a - source + dest, endpoint - source + dest])
				a = endpoint + 1
			else if a < source <= z <= endpoint then
				newIntervals.push([dest, z - source + dest])
				z = source - 1
			end if
			
		end for
		if not intervalFound then
			newIntervals.push([a,z])
		end if
	end while
	seedIntervals = newIntervals
end for

seedIntervals.sort(1)
print seedIntervals[0][0]
