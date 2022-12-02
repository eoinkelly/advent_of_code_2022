require "active_support/all"

carried_calories = File.readlines("day_1_part_1_input.txt", chomp: true)
                       .split("") # rubocop:disable Style/StringChars
                       .map { |items| items.sum(&:to_i) }

puts "Part 1: #{carried_calories.max}"
puts "Part 2: #{carried_calories.sort.last(3).sum}"
