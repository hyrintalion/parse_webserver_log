require_relative '../log_parsing'
require 'rspec'

describe LogParsing do
  subject {described_class.new(file)}

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
        '/about/2' => 1,
        '/contact' => 2,
        '/home' => 3
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
        '/about/2' => 1,
        '/home' => 2,
        '/contact' => 2
      }
    end
    let(:sorted_result_number_of_uniq_visits) do
      {
        '/home' => 2,
        '/contact' => 2,
        '/about/2' => 1
      }
    end

    it 'then initialize, content have array of hashes' do
      expect(subject.content).to eq parsed_file_content
    end

    it 'then we count number_of_visits, result have hash with numbers' do
      result = subject.send(:number_of_visits, parsed_file_content)
      expect(result).to eq result_number_of_visits
    end

    it 'sort number_of_visits' do
      result = subject.send(:sort_by_visits, result_number_of_visits)
      expect(result).to eq sorted_result_number_of_visits
    end

    it 'then we count number_of_visits, result have hash with numbers' do
      result = subject.send(:number_of_visits, parsed_file_content.uniq)
      expect(result).to eq result_number_of_uniq_visits
    end

    it 'sort number_of_uniq_visits' do
      result = subject.send(:sort_by_visits, result_number_of_uniq_visits)
      expect(result).to eq sorted_result_number_of_uniq_visits
    end

    it 'webpages_with_most_page_views ' do
      result = subject.webpages_ordered_by_views
      expect(result).to eq sorted_result_number_of_visits
    end

    it 'webpages_with_most_page_views ' do
      result = subject.webpages_ordered_by_uniq_views
      expect(result).to eq sorted_result_number_of_uniq_visits
    end
  end

  context 'errors' do
    context 'file doesn`t exists' do
      let(:file) { 'spec/i_am_not_here.log' }

      it 'then initialize, raise error' do
        expect { subject }.to raise_error(Errno::ENOENT)
      end
    end

    context 'file with wrong content' do
      let(:file) { 'spec/wrong_test_webserver.log' }

      it 'wrong content' do
        allow(File).to receive(:new).and_return('wrong format of content')
        expect { subject }.to raise_error(LogParsing::FileContentError)
      end

      it 'wrong webpage' do
        allow(File).to receive(:new).and_return('184123665067 184.123.665.067')
        expect { subject }.to raise_error(LogParsing::FileContentError)
      end

      it 'wrong ip' do
        allow(File).to receive(:new).and_return('/sdfhomdfgsdd 1.2.3.4')
        expect { subject }.to raise_error(LogParsing::FileContentError)
      end
    end

  end
end