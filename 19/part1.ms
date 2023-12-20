if 1 then fn = "input.txt" else fn = "sample.txt"
data = file.readLines(fn)

mapCopy = function(m)
	res = {}
	for kv in m
		res[kv.key] = kv.value
	end for
	return res
end function

toRule = function(s)
	rules = []
	s = s.split(",")
	for r in s
		if r.indexOf(":") == null then
			rules.push(r)
		else
			part = r[0]
			op = sign("<=>".indexOf(r[1]) - 1)
			r = r[2:].split(":")
			value = r[0].val
			next = r[1]
			rules.push [part, op, value, next]
		end if
	end for
	return rules
end function

addToWorkflows = function(wf, s)
	s = s.split("{")
	name = s[0]
	rules = toRule(s[1][:-1])
	wf[name] = rules
end function

addPartNums = function(parts, s)
	s = s[1:-1]
	items = {}
	for p in s.split(",")
		pn = p.split("=")
		items[pn[0]] = val(pn[1])
	end for
	parts.push(items)
end function

workflows = {}
parts = []

while data[0] != ""
	addToWorkflows(workflows, data.pull)
end while

data.pull // remove the empty line between sections

while data and data[0] != ""
	addPartNums(parts, data.pull)
end while
ans = 0
for partNums in parts
	wf = "in"
	while wf != "A" and wf != "R"
		for rule in workflows[wf]
			if not(rule isa string) then
				part = rule[0]
				op = rule[1]
				value = rule[2]
				next = rule[3]
				if partNums[part] * op > value * op then
					wf = next
					break
				end if
			else
				wf = rule
			end if
		end for
	end while
	if wf == "A" then
		ans += sum(partNums.values)
	end if
end for
print ans

// part 2
nodes = [["in", {"x": [1,4000], "m": [1,4000], "a": [1,4000], "s": [1,4000]}]]
parts = []
while nodes
	node = nodes.pop
	wf = node[0]
	p1 = node[1]
	for rule in workflows[wf]
		if not(rule isa string) then
			part = rule[0]
			op = rule[1]
			value = rule[2]
			next = rule[3]
			
			p2 = mapCopy(p1)
			if op == -1 then
				p2[part] = [p2[part][0], value - 1]
				p1[part] = [value, p1[part][1]]
			else if op == 1 then
				p2[part] = [value + 1, p2[part][1]]
				p1[part] = [p1[part][0], value]
			end if
			
			if next == "A" then
				parts.push(mapCopy(p2))
			else if next != "R" then
				nodes.push([next, mapCopy(p2)])
			end if
		else
			if rule == "A" then
				parts.push(mapCopy(p1))
			else if rule != "R" then
				nodes.push([rule, mapCopy(p1)])
			end if
		end if
	end for
end while
ans = 0
for part in parts
	product = 1
	for ranges in part.values
		diff = ranges[1] - ranges[0] + 1
		product *= diff
	end for
	ans += product
end for
print ans