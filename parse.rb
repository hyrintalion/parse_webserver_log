#!/usr/bin/ruby
require_relative 'log_parsing'

# parse.rb
def parse(file)
  parsing = LogParsing.new(file)

  puts 'List of webpages with most page views ordered from most pages views to less page views:'
  parsing.webpages_ordered_by_views.each do |webpage, visits|
    if visits == 1
      puts "#{webpage} #{visits} visit"
    else
      puts "#{webpage} #{visits} visits"
    end
  end

  puts 'List of webpages with most unique page views ordered from most pages views to less page views:'
  parsing.webpages_ordered_by_uniq_views.each do |webpage, visits|
    if visits == 1
      puts "#{webpage} #{visits} unique view"
    else
      puts "#{webpage} #{visits} unique views"
    end
  end
  return 0
rescue Errno::ENOENT
  puts 'File not found'
  return 2
rescue LogParsing::FileContentError
  puts 'File have incorrect structure'
  return 3
end

def run
  if ARGV.empty?
    puts 'Please set filename.'
    return 1
  else
    parse(ARGV[0])
  end
end

run()