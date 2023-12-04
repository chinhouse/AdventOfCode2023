data = file.readLines("input.txt")
if not data[-1] then data.pop

cards = [1] * data.len
sum = 0

for lineNum in data.indexes
	line = data[lineNum][8:]
	pieces = line.split(" | ")
	winner = pieces[0].split(" ")
	numbers = pieces[1].split(" ")
	count = 0
	for n in numbers
		if winner.indexOf(n) != null and n != "" then count += 1
	end for
	
	if count != 0 then
		sum += 2 ^ (count - 1)
	end if
	
	if count > 0 then
		for n in range(lineNum+1, lineNum+count)
			if n == data.len then break
			cards[n]=cards[n]+cards[lineNum]
		end for
	end if
	print [lineNum+1, count, cards]
	count = 0
end for
print "Day 4, part1: " + sum
print "Day 4, part2: " + cards.sum