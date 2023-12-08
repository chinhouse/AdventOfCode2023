data =file.readLines("input.txt")
if not data[-1] then data.pop

gcd = function(a, b)
	while b
		temp = b
		b = a % b
		a = temp
	end while
	return a
end function

lcm = function(a, b)
	return (a / gcd(a, b)) * b
end function

lcmList = function(arr)
	if arr.len == 0 then
		print "Nothingburger!"
		exit
	end if
	
	res = arr[0]
	for n in arr[1:]
		res = lcm(res, n)
	end for
	return res
end function

instructions = data[0]
lines = data[2:]
nodes = {}
for line in lines
	nodes[line[:3]] = [line[7:10],line[12:15]]
end for

//part 1
count = 0
curNode = "AAA"
while curNode != "ZZZ"
	curNode = nodes[curNode][instructions[count % instructions.len] == "R"]
	count += 1
end while
print "Day 8, part 1: " + count

//part 2
counts = []
endsA = []
for n in nodes
	if n["key"][-1] == "A" then
		counts.push(0)
		endsA.push(n.key)
	end if
end for
print "Found " + nodes.len + " nodes that end in A"

for i in range(0, endsA.len - 1)
	curNode = endsA[i]
	while curNode[-1] != "Z"
		curNode = nodes[curNode][instructions[counts[i] % instructions.len] == "R"]
		counts[i] += 1
	end while
end for
print "Day 8, part 2: " + lcmList(counts)
