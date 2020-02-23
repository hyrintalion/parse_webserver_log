class LogParsing

  attr_reader :content

  def initialize(file)
    @content = fetch_file_content file
  end

  def webpages_with_most_page_views
    visits = number_of_visits(file_content)
    sorted_visits = sort_by_visits(visits)

    sorted_visits
  end

  def webpages_with_most_unique_page_views
    visits = number_of_visits(content.uniq)
    sorted_uniq_visits = sort_by_visits(visits)

    sorted_uniq_visits
  end

  private

  def fetch_file_content(file)
    result = []
    content = File.new(file)
    content.each_line { |line|
      arr = line.split(' ')
      result << {webpage: arr.first, ip: arr.last}
    }
    result
  end

  def number_of_visits(file_content)
    result = {}
    file_content.each do |line|
      webpage = line[:webpage]
      unless result[webpage]
        result[webpage] = 1
      else
        result[webpage] += 1
      end
    end
    result
  end

  def sort_by_visits(visits)
    visits.sort_by {|k, v| v}.reverse.to_h
  end
end