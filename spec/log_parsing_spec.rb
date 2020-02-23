require_relative '../log_parsing'
require 'rspec'

describe LogParsing do
  context 'happy path' do
    let(:file) { 'spec/test_webserver.log' }
    let(:parsed_file_content) do
      [
        { webpage: '/home', ip: '184.123.665.067'},
        { webpage: '/contact', ip: '184.123.665.067'},
        { webpage: '/home', ip: '184.123.665.067'},
        { webpage: '/contact', ip: '555.576.836.194'},
        { webpage: '/about/2', ip: '444.701.448.104'},
        { webpage: '/home', ip: '929.398.951.889'},
      ]
    end
    let(:result_number_of_visits) do
      {
        '/home' => 3,
        '/contact' => 2,
        '/about/2' => 1
      }
    end
    let(:sorted_result_number_of_visits) do
      {
        '/home' => 3,
        '/contact' => 2,
        '/about/2' => 1
      }
    end
    let(:result_number_of_uniq_visits) do
      {
        '/home' => 2,
        '/contact' => 2,
        '/about/2' => 1
      }
    end
    let(:sorted_result_number_of_uniq_visits) do
      {
        '/home' => 2,
        '/contact' => 2,
        '/about/2' => 1
      }
    end

    subject {described_class.new(file)}

    it 'then initialize, content have array of hashes' do
      expect(subject.content).to eq parsed_file_content
    end

    it 'then we count number_of_visits, result have hash with numbers' do
      result = subject.send(:number_of_visits, parsed_file_content)
      expect(result).to eq result_number_of_visits
    end

    it 'sort number_of_visits' do
      result = subject.send(:sort_by_visits, result_number_of_visits)
      expect(result).to eq result_number_of_visits
    end

    it 'should return text about visits' do
      expect { subject.webpages_with_most_page_views }.
        to output( "\"[\\\"/home\\\", 3] 0 visits\"\n\"[\\\"/contact\\\", 2] 1 visit\"\n\"[\\\"/about/2\\\", 1] 2 visits\"\n").to_stdout
    end

    it 'should return text about unique visits' do
      expect { subject.webpages_with_most_unique_page_views }.
        to output("\"[\\\"/contact\\\", 2] 0 unique views\"\n\"[\\\"/home\\\", 2] 1 unique view\"\n\"[\\\"/about/2\\\", 1] 2 unique views\"\n").to_stdout
    end
  end
end