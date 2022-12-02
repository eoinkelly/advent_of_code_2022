my_play_scores = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

outcome_scores = {
  # their_play, my_play
  %w[A X] => 3, # rock, rock
  %w[A Y] => 6, # rock, paper
  %w[A Z] => 0, # rock, scissors
  %w[B X] => 0, # paper, rock
  %w[B Y] => 3, # paper, paper
  %w[B Z] => 6, # paper, scissors
  %w[C X] => 6, # scissors, rock
  %w[C Y] => 0, # scissors, paper
  %w[C Z] => 3 # scissors, scissors
}

winning_plays = {
  "A" => "Y", # rock, paper
  "B" => "Z", # paper, scissors
  "C" => "X" # scissors, rock
}

drawing_plays = {
  "A" => "X", # rock, rock
  "B" => "Y", # paper, paper
  "C" => "Z" # scissors, scissors
}

losing_plays = {
  "A" => "Z", # rock, scissors
  "B" => "X", # paper, rock
  "C" => "Y" # scissors, paper
}

desired_outcome_scores = {
  "X" => 0, # lose
  "Y" => 3, # draw
  "Z" => 6 # win
}

raw_data = File.readlines("day_2_part_1_input.txt", chomp: true)

part_1_answer = raw_data.sum do |line|
  their_play, my_play = line.split(/\s+/)
  my_play_scores.fetch(my_play) + outcome_scores.fetch([their_play, my_play])
end

puts "Part 1: #{part_1_answer}"

part_2_answer = raw_data.sum do |line|
  their_play, desired_outcome = line.split(/\s+/)

  my_play = case desired_outcome
            when "X"
              losing_plays.fetch(their_play)
            when "Y"
              drawing_plays.fetch(their_play)
            when "Z"
              winning_plays.fetch(their_play)
            end

  my_play_scores.fetch(my_play) + desired_outcome_scores.fetch(desired_outcome)
end

puts "Part 2: #{part_2_answer}"
