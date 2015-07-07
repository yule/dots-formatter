class TestOutput

  attr_accessor :messages

  def initialize
    @messages = []
  end

  def puts(message)
    @messages << message
  end
end

describe 'dots formatter' do

  let(:output){TestOutput.new}
  let(:formatter){DotsFormatter.new(output)}

  it 'should set the default values' do
    expect(formatter.fails).to eq(0)
    expect(formatter.passes).to eq(0)
    expect(formatter.fails).to eq(0)
    expect(formatter.runs).to eq(0)
    expect(formatter.pendings).to eq(0)
    expect(formatter.debug).to eq(false)
  end

end
