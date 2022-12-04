require "set"

_raw_example_data = <<~EO_DATA
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
EO_DATA
_example_data = example_data.lines(chomp: true)

raw_data = File.readlines("day_4_part_1_input.txt", chomp: true)

input_as_ranges = raw_data.map do |line|
  left, right = line.split(",")
  left_start, left_end = left.split("-").map(&:to_i)
  right_start, right_end = right.split("-").map(&:to_i)

  left_range = left_start..left_end
  right_range = right_start..right_end

  [left_range, right_range]
end

part_1_answer = input_as_ranges.sum do |left_range, right_range|
  left_range.cover?(right_range) || right_range.cover?(left_range) ? 1 : 0
end

puts "Part 1: #{part_1_answer}"

part_2_answer = input_as_ranges.sum do |left_range, right_range|
  left_set = Set.new(left_range.to_a)
  right_set = Set.new(right_range.to_a)

  left_set.intersect?(right_set) ? 1 : 0
end

puts "Part 2: #{part_2_answer}"
