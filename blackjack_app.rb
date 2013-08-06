def calculate_total(cards)
	arr = cards.map{|e| e[1] }

	total = 0
	arr.each do |value|
		if value == "A"
			total += 11
		elsif value.to_i == 0
			total += 10
		else 
			total += value.to_i
		end
	end

	arr.select{|e| e == "A"}.count.times do
			total -= 10 if total > 21
	end

	total
end

def hit(deck, mycards)
	mycards << deck.pop
end

def dealer_hit(deck, dealercards)
	dealercards << deck.pop
end

puts "Welcome to Blackjack!"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show Cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}"
puts ""
puts "What would you like to do 1) hit 2) stay"

hit_or_stay = gets.chomp

if hit_or_stay == 1
	hit(deck, mycards)
	mytotal = calculate_total(mycards)

	dealer_hit(deck, dealercards) if dealertotal < 17
	dealertotal = calculate_total(dealercards)

	puts "Dealer has a total of #{dealertotal}"
	puts "You have a total of #{mytotal}"
else
	dealer_hit(deck, dealercards) if dealertotal < 17
	dealertotal = calculate_total(dealercards)

	puts "Dealer has a total of #{dealertotal}"
	puts "You have a total of #{mytotal}"
end







