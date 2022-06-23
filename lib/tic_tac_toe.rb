require 'pry'

class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        @board = []
        9.times { @board << " " }
    end

    def display_board
        line = "#{'-' * 11}"
        rows = []
        self.board.each_slice(3) { |row| rows << row}
        joined_rows = rows.map { |row| " " + row.join(' | ') + " " }
        puts joined_rows[0]
        puts line
        puts joined_rows[1]
        puts line
        puts joined_rows[2]
    end

    def input_to_index index
        index.to_i - 1
    end

    def move index, token = "X"
        self.board[index] = token
    end

    def position_taken? index
        self.board[index] != " "
    end

    def valid_move? index
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn_count
        self.board.filter{ |space| space != " " }.length
    end

    def current_player
        turn_count.odd? ? "O" : "X"
    end

    def turn
        index = input_to_index(gets.chomp)
        valid_move?(index) ? move(index, current_player) : turn
        display_board
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            checked_combo = []
            combo.each { |index| checked_combo << board[index]}
            !checked_combo.include?(" ") && checked_combo.uniq.length == 1
        end
    end

    def full?
        !board.include?(' ')
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        turn_count.even? ? "O" : "X" if won?
    end

    def play
        turn until over?
        puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end

# binding.pry
# 0