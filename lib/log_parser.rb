require 'terminal-table'
require 'byebug'

class LogParser

  attr_reader :log_file, :top_three_url, :all_codes

  def initialize(file_path)
    @log_file      = read(file_path)
    @top_three_url = nil
    @all_codes     = nil
  end

  def read(file_path)
    if File.exists? file_path
      return File.read(file_path) rescue nil
    else
      puts "The file path is invalid"
      return nil
    end
  end

  def process
    if @log_file
      top_three_url_process
      all_codes_process
      puts "Log file successfully processed"
    else
      puts "Log file was not defined yet. Please set a valid log file"
    end
  end

  def top_three_url_process
    urls = @log_file.scan(/level=.*request_to="(.*)".*response_status=.*/i).flatten
    grouped_urls = urls.each_with_object(Hash.new(0)){|k, v| v[k] += 1}

    @top_three_url = grouped_urls.sort_by(&:last).reverse.take(3)
  end

  def print_top_three
    if @top_three_url
      Terminal::Table.new(title: "Top Three URLs", headings: [ 'URL', 'Occurrence'], rows: @top_three_url)
    else
      "Log unprocessed. Please run step 2 before trying this"
    end
  end

  def all_codes_process
    codes = @log_file.scan(/.*response_status="(.*)"/i).flatten
    grouped_codes = codes.each_with_object(Hash.new(0)){|k, v| v[k] += 1}

    @all_codes = grouped_codes.sort_by(&:last).reverse
  end

  def print_all_codes
    if @all_codes
      Terminal::Table.new(title: "Code occurrence", headings: [ 'Code', 'Occurrence'], rows: @all_codes)
    else
      "Log unprocessed. Please run step 2 before trying this"
    end
  end

end



