class LogParsing
  class FileContentError < StandardError; end

  attr_reader :content

  def initialize(file)
    @content = fetch_file_content(file)
  end

  def webpages_ordered_by_views
    visits = number_of_visits(content)
    sort_by_visits(visits)
  end

  def webpages_ordered_by_uniq_views
    visits = number_of_visits(content.uniq)
    sort_by_visits(visits)
  end

  private

  def fetch_file_content(file)
    result = []
    content = File.new(file)

    content.each_line do |line|
      arr = line.split(' ')

      if arr.count == 2 && is_webpage(arr[0]) && is_ip(arr[1])
        result << {webpage: arr[0], ip: arr[1]}
      else
        raise FileContentError
      end
    end

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

  def is_webpage(webpage)
    webpage.chars.first == '/'
  end

  def is_ip(ip)
    # I don't do the real regular extention, because in webserver.log file we have wrong ip like 646.865.545.408
    # I will take it for the right case and verify only structure
    ip.match(/[0-9]{3}.[0-9]{3}.[0-9]{3}.[0-9]{3}/)
  end
end