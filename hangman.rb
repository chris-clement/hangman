#Hangman
options_list = []
special = "?<>',?[]}{=-)(*&^%$#`~{}:"
puts "Welcome to Hangman."
puts "What is your name please?"
name = gets.chomp.capitalize
puts "Hi there, #{name}! Let's get started."
puts "We can play hangman based on a few topics. Select from the following:"
while true
  puts "'Films' or 'Music' or 'TV'"
  game_genre = gets.chomp.downcase.capitalize
  if game_genre == "Films"
    filename = "imdb.txt"
    puts "Great, I love films!"
    break
  elsif game_genre == "Music"
    filename = "top_artists.txt"
    puts "I love Music, this is based on Artist names."
    break
  elsif game_genre == "Tv"
    filename = "tv_shows.txt"
    puts "I love TV, let's see what you know!"
    break
  else
    puts "Sorry I don't recognize your choice. Try again."
  end
end

File.open(filename, "r").each {|line| options_list << line.strip}

options_choice = options_list[rand(0...options_list.length)].upcase
incorrect_guesses = []
correct_guesses = []
options_choice_letters = options_choice.chars.uniq
options_choice_letters.delete(" ")

while true
  puts "What difficulty would you like #{name}? Hard, Medium or Easy?"
  puts "Enter H, M, E"
  difficulty = gets.chomp.upcase
  if difficulty == "H"
    guesses_left = 4
    break
  elsif difficulty == "M"
    guesses_left = 6
    break
  elsif difficulty == "E"
    guesses_left = 8
    break
  else
    puts "Invalid entry #{name}. Try again."
  end
end

while guesses_left > 0
  for i in 0...(options_choice.length)
    if (correct_guesses).include?(options_choice[i]) || options_choice[i] == " " || special.include?(options_choice[i])
      print options_choice[i]
    else
      print "*"
    end
  end
  if options_choice_letters.sort == correct_guesses.sort
    puts
    puts "You guessed it correctly!"
    puts "You clearly know your #{game_genre}."
    puts "Congrats #{name}, you win!"
    exit
  end
  puts
  puts "You have #{guesses_left} guesses remaining #{name}."
  puts "Let's have a guess at a letter:"
  guess = gets.chomp.upcase
  if incorrect_guesses.include?(guess) || correct_guesses.include?(guess)
    puts "You already guessed that letter #{name}!"
  elsif options_choice.include?(guess)
    puts "Correct"
    correct_guesses << guess
  else
    puts "No, sadly that letter is not there."
    incorrect_guesses << guess
    guesses_left -= 1
    puts "Incorrectly guessed so far: #{incorrect_guesses}"
  end
end

puts "You ran out of guesses."
puts "It was \"#{options_choice}\" of course #{name}!"
puts "Maybe you need to scrub up on your #{game_genre} knowledge."
puts "GAME OVER!"
