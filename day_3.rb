# example_data = <<~EO_DATA
#   vJrwpWtwJgWrhcsFMMfFFhFp
#   jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#   PmmdzqPrVvPwwTWBwg
#   wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#   ttgJtRGJQctTZtZT
#   CrZsJsPPZsGzwwsLwLmpwMDw
# EO_DATA
# ex_data = example_data.lines(chomp: true)

PRIORITIES = ["-"] + ("a".."z").to_a + ("A".."Z").to_a

def priority_for(char)
  PRIORITIES.index(char)
end

raw_data = File.readlines("day_3_part_1_input.txt", chomp: true)

part_1_answer = raw_data.sum do |line|
  middle_idx = line.length / 2
  left = line[0...middle_idx]
  right = line[middle_idx..]
  common_char = left.chars.intersection(right.chars).first
  priority_for(common_char)
end

puts "Part 1: #{part_1_answer}"

part_2_answer = raw_data.each_slice(3).sum do |group|
  group_as_char_arrays = group.map(&:chars)
  common_char = group_as_char_arrays[0].intersection(group_as_char_arrays[1])
                                       .intersection(group_as_char_arrays[2])
                                       .first
  priority_for(common_char)
end

puts "Part 2: #{part_2_answer}"
