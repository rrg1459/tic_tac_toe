# ---------------------------------------------------------------
class Board

	attr_accessor :ttt, :aaa, :player_1, :player_2, :p_1, :p_2, :counter, :turn

	def initialize
		self.ttt      = ["1","2","3","4","5","6","7","8","9"]
		self.aaa      = [" "," "," "," "," "," "," "," "," "]
		self.counter  = 0
		self.turn     = true
	end

	def gaming?
		gaming = true
		if    ( aaa[0] == aaa[1] && aaa[0] == aaa[2] ) && aaa[0] != " " # row 1
			gaming = false
		elsif ( aaa[3] == aaa[4] && aaa[3] == aaa[5] ) && aaa[3] != " " # row 2
			gaming = false
		elsif ( aaa[6] == aaa[7] && aaa[6] == aaa[8] ) && aaa[6] != " " # row 3
			gaming = false
		elsif ( aaa[0] == aaa[3] && aaa[0] == aaa[6] ) && aaa[0] != " " # col 1
			gaming = false
		elsif ( aaa[1] == aaa[4] && aaa[1] == aaa[7] ) && aaa[1] != " " # col 2
			gaming = false
		elsif ( aaa[2] == aaa[5] && aaa[2] == aaa[8] ) && aaa[2] != " " # col 3
			gaming = false
		elsif ( aaa[0] == aaa[4] && aaa[0] == aaa[8] ) && aaa[0] != " " # diagonal 1
			gaming = false
		elsif ( aaa[2] == aaa[4] && aaa[2] == aaa[6] ) && aaa[2] != " " # diagonal 2
			gaming = false
		end
		gaming
	end

	def calculate
		if !gaming? # reverse the last play
			turn ? (self.turn = false) : (self.turn = true)
		end
		turn ? (num, mark = 1, p_1) : (num, mark = 2, p_2)
		if gaming?
			if counter > 8
				@line = "  ║            no body won            ║"
			else
				@line = "  ║  play the player #{num} with #{mark}         ║"
			end
		else
			@line   = "  ║ The winner is the player #{num} with #{mark} ║"
		end
	end

	def to_s
		return "\n" +
		"    player 1 is #{player_1}\n" +
		"    player 2 is #{player_2}\n" +
		"  ╔═════════════════╦═════════════════╗\n" +
		"  ║    REFERENCE    ║      BOARD      ║\n" +
		"  ╠═════════════════╬═════════════════╣\n" +
		"  ║                 ║                 ║\n" +
		"  ║    #{ttt[0]} │ #{ttt[1]} │ #{ttt[2]}    ║    #{aaa[0]} │ #{aaa[1]} │ #{aaa[2]}    ║\n" +
		"  ║   ───┼───┼───   ║   ───┼───┼───   ║\n" +
		"  ║    #{ttt[3]} │ #{ttt[4]} │ #{ttt[5]}    ║    #{aaa[3]} │ #{aaa[4]} │ #{aaa[5]}    ║\n" +
		"  ║   ───┼───┼───   ║   ───┼───┼───   ║\n" +
		"  ║    #{ttt[6]} │ #{ttt[7]} │ #{ttt[8]}    ║    #{aaa[6]} │ #{aaa[7]} │ #{aaa[8]}    ║\n" +
		"  ║                 ║                 ║\n" +
		"  ╠═════════════════╩═════════════════╣\n" +
		"#{@line}\n" +
		"  ╚═══════════════════════════════════╝\n"
	end
end

# ---------------------------------------------------------------
class Game
	def initialize
		@game = Board.new
		set_players
		set_marks
		play
	end

	def set_players
		puts
		while true
			print "Enter name of player 1? "
			@game.player_1 = gets.chomp
			break unless @game.player_1 == ''
		end
		puts
		while true
			print "Enter name of player 2? "
			@game.player_2 = gets.chomp
			break unless @game.player_2 == ''
		end
	end

	def set_marks
		puts
		while true
			print "#{@game.player_1}, choose X or O: "
			mark = gets.chomp.upcase
			break if mark == "X" || mark == "O"
		end
		@game.p_1 = mark
		@game.p_2 = (mark == "X") ? "O" : "X"
	end

	def play
		while true
			system "clear"  #linux
			@game.calculate
			puts @game
			if @game.gaming? && @game.counter < 9
				puts  '    please type "e" to exit'
				print "    please choose a number: "
				ans = gets.chomp.downcase
				puts
				exit if ans == 'e'
				if ans != ''
					num = ans.to_i
					in_range = false
					if num.to_s == ans.to_s
						in_range = true if (1..9).include?(num) && (1..9).include?(@game.ttt[num - 1].to_i)
					end
					if in_range
						@game.counter += 1
						@game.ttt[num - 1] = " "
						@game.turn ? (@game.aaa[num - 1] = @game.p_1) : (@game.aaa[num - 1] = @game.p_2)
						@game.turn = !@game.turn
					end
				end
			else
				break
			end
		end
	end

end
#
# Main program
# ---------------------------------------------------------------
while true
	Game.new
	print "\n    Play again? (y): "
	ans = gets.chomp.downcase
	puts 
	break  if ans != 'y'
end
