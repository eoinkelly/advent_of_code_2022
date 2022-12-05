##
# The semantics of this stack do not exactly match Ruby's Array so we implement
# our own stack
#
class Stack
  def self.stacks_from_puzzle_input(data)
    stacks = []

    data.lines do |line|
      parts = line.chars.each_slice(4).map(&:join)
      parts.each_with_index do |part, i|
        next if part.match?(/\A(\s|\d)*\z/)

        stacks[i] ||= Stack.new
        stacks[i].unshift(part[1])
      end
    end

    stacks
  end

  def top
    @store[-1]
  end

  def initialize
    # top of stack is on the right
    @store = []
  end

  def unshift(value)
    @store.unshift(value)
  end

  def pop(num_items = 1)
    result = @store.pop(num_items)
    result.instance_of?(Array) ? result : [result]
  end

  def push(values)
    @store += values
  end

  def inspect
    "Stack: (bottom) #{@store.join(" -> ")} (top)"
  end
end

class Move
  MOVE_LINE_REGEX = /move (?<num_crates>\d+) from (?<from_stack_num>\d+) to (?<to_stack_num>\d+)/.freeze

  def self.moves_from_puzzle_input(input)
    input.lines(chomp: true).map do |line|
      matches = line.match(MOVE_LINE_REGEX)
      Move.new(
        num_crates: matches[:num_crates],
        from_stack_num: matches[:from_stack_num],
        to_stack_num: matches[:to_stack_num]
      )
    end
  end

  attr_reader :num_crates, :from_stack_idx, :to_stack_idx

  def initialize(num_crates:, from_stack_num:, to_stack_num:)
    @num_crates = Integer(num_crates)
    @from_stack_idx = Integer(from_stack_num) - 1
    @to_stack_idx = Integer(to_stack_num) - 1
  end
end

# Example input
# raw_example_stacks = <<~EO_STACKS
#       [D]
#   [N] [C]
#   [Z] [M] [P]
#    1   2   3
# EO_STACKS
# raw_example_moves = <<~EO_MOVES
#   move 1 from 2 to 1
#   move 3 from 1 to 3
#   move 2 from 2 to 1
#   move 1 from 1 to 2
# EO_MOVES
# stacks_part_1 = Stack.stacks_from_puzzle_input(raw_example_stacks)
# stacks_part_2 = Stack.stacks_from_puzzle_input(raw_example_stacks)
# moves = Move.moves_from_puzzle_input(raw_example_moves)

# Real puzzle input
stacks_part_1 = Stack.stacks_from_puzzle_input(File.read("day_5_stacks.txt"))
stacks_part_2 = Stack.stacks_from_puzzle_input(File.read("day_5_stacks.txt"))
moves = Move.moves_from_puzzle_input(File.read("day_5_moves.txt"))

def part_1_exec_moves(stacks, moves)
  moves.each do |move|
    values = stacks[move.from_stack_idx].pop(move.num_crates)
    stacks[move.to_stack_idx].push(values.reverse)
  end

  stacks.map(&:top).join
end

def part_2_exec_moves(stacks, moves)
  moves.each do |move|
    values = stacks[move.from_stack_idx].pop(move.num_crates)
    stacks[move.to_stack_idx].push(values)
  end

  stacks.map(&:top).join
end

puts "Part 1: #{part_1_exec_moves(stacks_part_1, moves)}"
puts "Part 2: #{part_2_exec_moves(stacks_part_2, moves)}"
