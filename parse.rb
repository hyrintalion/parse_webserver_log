require_relative 'log_parsing'

# parse.rb
def parse(file)
  parsing = LogParsing.new(args[:file])

  parsing.webpages_ordered_by_views.each_with_index do |webpage, visits|
    if visits == 1
      p "#{webpage.to_s} #{visits} visit"
    else
      p "#{webpage} #{visits} visits"
    end
  end

  parsing.webpages_ordered_by_uniq_views.each_with_index do |webpage, visits|
    if visits == 1
      p "#{webpage} #{visits} unique view"
    else
      p "#{webpage} #{visits} unique views"
    end
  end
rescue Errno::ENOENT
  p 'File not found'
rescue LogParsing::FileContentError
  p 'File have incorrect structure'
end
