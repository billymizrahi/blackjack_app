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

def restart(playagain)
  puts "Do you want to play again? 1) Yes 2) No"
  playagain = gets.chomp
  while playagain != "1" && playagain != "2"
    puts "Please enter 1) Yes 2) No"
    playagain = gets.chomp
  end
  return playagain
end

playagain = "0"

while playagain != "2"
  puts ""
  puts "**********************************"
  puts "Welcome to Blackjack!"
  puts "**********************************"
  puts ""

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
  puts "Dealer has #{dealercards[1]} showing"
  puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}"
  puts ""

  hit_or_stay = 0
  i = 2

  while hit_or_stay != "2" && mytotal < 21 
    puts "What would you like to do 1) hit 2) stay"
    hit_or_stay = gets.chomp
# Player hits
    if hit_or_stay == "1"
      hit(deck, mycards)
      puts "You drew a #{mycards[i]}"
      mytotal = calculate_total(mycards)
      puts "You have a total of #{mytotal}"
      puts ""
      i = i + 1
      if mytotal > 21
        puts "Sorry, you BUSTED!"
        puts ""
        playagain = restart(playagain)
      elsif mytotal == 21
        puts "YOU WIN!!! GIVE YOUR FRIEND A HUG ;)"
        puts ""
        playagain = restart(playagain)
      end
# Player stays
    elsif hit_or_stay == "2"
      puts "You have a total of #{mytotal}"
      puts ""
    end
  end
# Showing Dealer Cards
  if mytotal < 21
    puts "Dealer flips and shows a #{dealercards[0]} for a total of #{dealertotal}"

    i = 2
    while dealertotal < 17 
      dealer_hit(deck, dealercards)
      puts "Dealer draws a #{dealercards[i]}"
      dealertotal = calculate_total(dealercards)
      i = i + 1
      puts "Dealer has a total of #{dealertotal}"
      puts ""

      if dealertotal > 21
        puts "Dealer BUSTED! You Win!"
        puts ""
        playagain = restart(playagain)
      elsif dealertotal == 21
        puts "You lose, Dealer wins :("
        puts ""
        playagain = restart(playagain)
      end
    end
# Comparing Cards
    if dealertotal > 16 && dealertotal < 21
      if mytotal < dealertotal
        puts "You lose, Dealer wins :("
        puts ""
        playagain = restart(playagain)
      elsif mytotal > dealertotal
        puts "YOU WIN!!! GIVE YOUR FRIEND A HUG ;)"
        puts ""
        playagain = restart(playagain)
      else
        puts "PUSH! Tie game."
        puts ""
        playagain = restart(playagain)
      end
    end
  end
end


