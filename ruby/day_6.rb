def find_end_of_first_window(char_stream, window_size:)
  (0..(char_stream.length - window_size)).each do |i|
    window = char_stream[i, window_size]
    return i + window_size if window.length == window.chars.uniq.join.length
  end
end

# part_1_ex_1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
# part_1_ex_2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
# puts "Part 2: #{find_end_of_first_window(part_1_ex_1, window_size: 4)}"
# puts "Part 2: #{find_end_of_first_window(part_1_ex_2, window_size: 4)}"

puts "Part 1: #{find_end_of_first_window(File.read("../inputs/day_6_input.txt", chomp: true), window_size: 4)}"

# part_2_ex_1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
# part_2_ex_2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
# puts "Part 2: #{find_end_of_first_window(part_2_ex_1, window_size: 14)}"
# puts "Part 2: #{find_end_of_first_window(part_2_ex_2, window_size: 14)}"
puts "Part 2: #{find_end_of_first_window(File.read("../inputs/day_6_input.txt", chomp: true), window_size: 14)}"
