import "listUtil"
if 1 then fn = "input.txt" else fn = "sample.txt"

hands = file.readLines(fn)
if not hands[-1] then hands.pop

is5Kind = function(d)
	return d.len == 1
end function

is4Kind = function(d)
	return d.len == 2 and d.indexOf(4) != null
end function

isFullHouse = function(d)
	return d.indexOf(3) != null and d.indexOf(2) != null
end function

is3Kind = function(d)
	return d.len == 3 and d.indexOf(3) != null
end function

is2Pair = function(d)
	return d.len == 3 and d.indexOf(2) != null
end function

is1Pair = function(d)
	return d.len == 4 and d.indexOf(2) != null
end function

isHighCard = function(d)
	return d.len == 5
end function

// returns a string value that suitable for sorting
getSortHand = function(hand, joker = false)
	source = "23456789TJQKA"
	if joker then
		endpoint = "23456789A0CDE"
	else
		endpoint = "23456789ABCDE"
	end if
	for i in range(0, hand.len - 1)
		j = source.indexOf(hand[i])
		hand[i] = endpoint[j]
	end for
	return hand.join("")
end function

getBestHand = function(hand)
	handTypeResults = []
	faces = hand.distinct
	faces.removeVal("J")
	if not faces then return 0
	for f in faces
		aCopy = []
		for i in range(0, 4)
			if hand[i] == "J" then
				aCopy.push(f)
			else
				aCopy.push(hand[i])
			end if
		end for
		handTypeResults.push(getType(aCopy))
	end for
	return handTypeResults.min
end function

getType = function(hand, joker = false)
	if joker and hand.indexOf("J") != null then
		return getBestHand(hand)
	end if
	distinctCards = hand.counts.values
	if is5Kind(distinctCards) then return 0
	if is4Kind(distinctCards) then return 1
	if isFullHouse(distinctCards) then return 2
	if is3Kind(distinctCards) then return 3
	if is2Pair(distinctCards) then return 4
	if is1Pair(distinctCards) then return 5
	return 6
end function

HandInfo = {"hand": "","type": 0, "bid": 0, "orig": "", "lineNum": 0}
getWinnings = function(joker = false)
	handInfos = []
	i = 1
	for hand in hands
		hand = hand.split(" ")
		info = new HandInfo
		info.lineNum = i // only used for debugging
		info.bid = hand[1].val
		info.orig = hand[0]
		
		hand = hand[0].split("")
		info.type = getType(hand, joker)
		info.hand = getSortHand(hand, joker)
		handInfos.push(info)
		i += 1
	end for
	
	handInfos.sort("hand",0).sort("type").reverse
	winnings = 0
	for i in range(0, handInfos.len - 1)
		info = handInfos[i]
		winnings += handInfos[i].bid * (i + 1)
	end for
	
	return winnings
end function

print "Day 7, part 1: " + getWinnings(false)
print "Day 7, part 2: " + getWinnings(true)