require 'weather'

describe Weather do
	it 'responds to Sunny?' do
		expect(subject).to respond_to :Sunny?
	end

	it 'responds to Stormy?' do
		expect(subject).to respond_to :Stormy?
	end

  it 'returns sunny when generator is less than 80' do
		allow(subject).to receive(:generator){50}
		expect(subject.Sunny?).to eq true
	end

	it 'return not stormy when generator is less than 80' do
		allow(subject).to receive(:generator){50}
		expect(subject.Stormy?).to eq false
	end

	it'returns not sunny when generator is over 80' do
		allow(subject).to receive(:generator){90}
		expect(subject.Sunny?).to eq false
	end

	it 'returns stormy when generator is over 80' do
		allow(subject).to receive(:generator){90}
		expect(subject.Stormy?).to eq true
	end
end
