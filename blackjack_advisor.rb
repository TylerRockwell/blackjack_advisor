def is_a_number(input)
  true if Float(input) rescue false
end

#Get required info from user

print "Please give me the value of your first card (A for Ace): "
pcard1 = gets.chomp
puts
print "Please give me the value of your second card (A for Ace): "
pcard2 = gets.chomp
puts
print "Please give me the value of the dealer's card (A for Ace): "
dcard = gets.chomp
puts

pcard1 == "A" || pcard2 == "A" ? handtype = "soft" : handtype = "hard"
