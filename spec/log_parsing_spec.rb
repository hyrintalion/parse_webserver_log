require 'rspec'
require_relative '../log_parsing'

describe LogParsing do
  let(:file) { '../webserver.log' }

  subject {(described_class.new(file)}

  it '' do
    expect(described_class.new(file)).to eq Object
  end
end