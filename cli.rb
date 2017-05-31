require_relative 'lib/log_parser.rb'

def prompt
  print '> '
end

def breakline
  puts "\n"
end

option = 0
while option != 5
  puts """
    Welcome to MOIP log reader

    1. Set log file
    2. Process file
    3. Get the three most called URLs
    4. Get all code occurrence
    5. Exit
  """
  prompt

  option = gets.chomp.to_i
  breakline

  case option
  when 1
    puts 'Please enter log path'
    prompt
    file_path   = gets.chomp
    @log_parser = LogParser.new(file_path)

    breakline

    puts @log_parser.log_file.nil? ? 'Sorry, but the log file was not read. Please try again' : 'Log file was successfully loaded'

  when 2
    @log_parser.process

  when 3
    puts @log_parser.print_top_three

  when 4
    puts @log_parser.print_all_codes

  when 5
    puts 'Bye bye user!'

  else
    puts 'Please select a correct option'

  end
end