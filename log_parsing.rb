class LogParsing

  attr_reader :file, :content

  def initialize(file)
    @file = file
    @content = fetch_file_content
  end

  def webpages_with_most_page_views
    # Нужно вернуть список вебстраниц с количеством просмотров от большего к меньшему
    #
    # Для этого надо:
    #
    # 1. Предположительно этим будет заниматься fetch_file_content
    # получить массив хешей вида
    # [{ webpage: '/help_page/1', ip: '126.318.035.038'}{ webpage: '/contact', ip: '184.123.665.067'}]
    #
    # 2. Сделать each, который будет считать количество просмотров и складывать это в отдельный хеш вида
    # [{webpage: '/home', visits: 90}{webpage: '/index', visits: 80}]
    #
    # 3. Отсортировать по возрастанию по полю visits
    #
    # 4. Вывести это все в виде
    #
    # /home 90 visits
    # /index 80 visits

  end

  def webpages_with_most_unique_page_views
    # Нужно вернуть список вебстраниц с УНИКАЛЬНЫМ количеством просмотров от большего к меньшему
    #
    # Для этого надо:
    #
    # 1. Предположительно этим будет заниматься fetch_file_content
    # получить массив хешей вида
    # [{ webpage: '/help_page/1', ip: '126.318.035.038'}{ webpage: '/contact', ip: '184.123.665.067'}]
    #
    # 2. Отсечь повторяющиеся ip
    #
    # 3. Сделать each, который будет считать количество просмотров и складывать это в отдельный хеш вида
    # [{webpage: '/home', visits: 90}{webpage: '/index', visits: 80}]
    #
    # 4. Отсортировать по возрастанию по полю visits
    #
    # 5. Вывести это все в виде
    #
    # /home 90 unique views
    # /index 80 unique views
  end

  private

  def fetch_file_content
    # получить массив хешей вида
    # [{ webpage: '/help_page/1', ip: '126.318.035.038'}{ webpage: '/contact', ip: '184.123.665.067'}]
  end
end