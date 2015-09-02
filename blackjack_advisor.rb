def is_a_number(input)
  true if Float(input) rescue false
end

def terminate(message="Terminating...")
  puts `clear`
  puts "#{message}"
  puts
  exit
end

def card_valid(card)
  if is_a_number(card)
    card = card.to_i
    card > 1 && card < 11 ? true : false
  elsif card == "A"
    true
  else
    false
  end
end

#Get required info from user
print "Please give me the value of your first card (A for Ace): "
p_card1 = gets.chomp
puts
print "Please give me the value of your second card (A for Ace): "
p_card2 = gets.chomp
puts
print "Please give me the value of the dealer's card (A for Ace): "
d_card = gets.chomp
puts

#Validate cards
terminate("You have entered invalid cards. Terminating...") if !(card_valid(p_card1) && card_valid(p_card2) && card_valid(d_card))

#Determine player's hand type and value
if is_a_number(p_card1) && is_a_number(p_card2)
  p_card1 == p_card2 ? hand_type = "pair" : hand_type = "hard"
  p_value = p_card1.to_i + p_card2.to_i

elsif p_card1 == "A" && p_card2 == "A"
  p_value = 22
  hand_type = "pair"
else
  hand_type = "soft"
  p_card1 == "A" ? p_value = 11 + p_card2.to_i : p_value = p_card1.to_i + 11
end

#Find dealer's card value
d_card != "A" ? d_value = d_card.to_i : d_value = d_card

##########################
# Determine optimal move #
##########################
hit_hash = Hash.new ("hit")
hit = "hit"
stand_hash = Hash.new ("stand")
stand = "stand"
dh_hash = Hash.new ("double down or hit")
dh = "double down or hit"
ds_hash = Hash.new ("double down or stay")
ds = "double down or stay"
hard_move = Hash.new()
soft_move = Hash.new()
pair_move = Hash.new()
split_hash = Hash.new("split")
spit = "split"

#Generate Hashes
######## Hard Hash ##############################
(5..8).each { |i| hard_move[i] = Hash.new("hit") }
#for i in 5..8 do hard_move[i] = hit_hash end
(9..11).each { |i| hard_move[i] = Hash.new("double down or hit")}
#for i in 9..11 do hard_move[i] = dh_hash end
hard_move[12] = Hash.new("hit")
for i in 13..21 do hard_move[i] = Hash.new("stand") end
for i in 17..21 do hard_move[i] = Hash.new("stand") end
#################################################

######## Soft Hash ###############################
(13..17).each { |i| soft_move[i] = Hash.new("hit") }
(18..21).each { |i| soft_move[i] = Hash.new("stand") }
##################################################


######## Pair Hash ###############################
(4..8).each { |i| pair_move[i] = Hash.new("split") }
#pair_move[8] = Hash.new("hit")
pair_move[10] = Hash.new("double down or hit")
(12..20).each { |i| pair_move[i] = Hash.new("split")}
pair_move[22] = Hash.new("split")

##################################################

#Hash overrides

######## Hard Hash ###############################
hard_move[8][5] = dh
hard_move[8][6] = dh
(7..10).each { |i| hard_move[9][i] = hit }
for i in 4..6 do hard_move[12][i] = stand end
hard_move[9]["A"] = hit
hard_move[9][10] = hit
hard_move[12][4] = stand
hard_move[12][5] = stand
hard_move[12][6] = stand
for i in 13..16
  for x in 7..10
    hard_move[i][x] = hit
  end
  hard_move[i]["A"] = hit
end
##################################################

######## Soft Hash ###############################
(13..17).each do |i|
  (4..6).each do |x|
    soft_move[i][x] = dh
  end
end
soft_move[17][2] = dh
soft_move[17][3] = dh
(3..6).each { |i| soft_move[18][i] = ds }
(9..10).each { |i| soft_move[18][i] = hit}
soft_move[19][6] = ds
##################################################

######## Pair Hash ###############################
(4..8).each do |i|
  (9..10).each do |x|
    pair_move[i][x] = hit
  end
  pair_move[i]["A"] = hit
end
(2..3).each { |i| pair_move[8][i] = hit }
(7..8).each { |i| pair_move[8][i] = hit }
pair_move[10][10] = hit
pair_move[10]["A"] = hit
(8..10).each { |i| pair_move[12][i] = hit }
pair_move[12]["A"] = hit
pair_move[14][9] = hit
pair_move[14][10] = stand
pair_move[14]["A"] = hit
pair_move[18][7] = stand
pair_move[18][10] = stand
pair_move[18]["A"] = stand
pair_move[20] = Hash.new("stand")


##################################################

#Output result to user
if hand_type == "hard"
  puts "Your optimal move is #{hard_move[p_value][d_value]}."
elsif hand_type == "soft"
  puts "Your optimal move is #{soft_move[p_value][d_value]}."
else
  puts "Your optimal move is #{pair_move[p_value][d_value]}."
end
