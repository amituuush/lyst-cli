require_relative "list"
require "byebug"

class TodoBoard
  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split(" ")

    case cmd
    when "mktodo"
      unless @list.add_item(*args)
        p "invalid date format, must be yyyy-mm-dd"
      else
        true
      end
    when "swap"
      @list.swap(*args.map(&:to_i))
    when "sort"
      @list.sort_by_date!
    when "priority"
      @list.print_priority
    when "print"
      args.empty? ? @list.print : @list.print_full_item(*args.first.to_i)
    when "toggle"
      @list.toggle_item(*args.first.to_i)
    when "quit"
        return false
    else
        print "Sorry, that command is not recognized."
        true
    end
  end

  def run
    loop do
      break if !get_command
    end
  end
end