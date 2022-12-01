require "active_support/all" # enable cheat-mode

carried_calories = File.readlines("day_1_part_1_input.txt", chomp: true)
                       .split("")
                       .map { |items| items.sum(&:to_i) }

puts "Part 1:"
puts carried_calories.max

puts "Part 2:"
puts carried_calories.sort.last(3).sum