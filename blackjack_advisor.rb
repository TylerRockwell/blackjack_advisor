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
  p_value = 12
  hand_type = "soft"
else
  hand_type = "soft"
  p_card1 == "A" ? p_value = 11 + p_card2.to_i : p_value = p_card1.to_i + 11
end

#Find dealer's card value
d_card != "A" ? d_value = d_card.to_i : d_value = d_card
