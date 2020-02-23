
task :parse, [:file] => :environment do |_, args|
  begin
    parsing = LogParsing.new(args[:file])

    parsing.webpages_with_most_page_views.each_with_index do |webpage, visits|
      if visits == 1
        p "#{webpage} #{visits} visit"
      else
        p "#{webpage} #{visits} visits"
      end
    end

    parsing.webpages_with_most_unique_page_views.each_with_index do |webpage, visits|
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
end