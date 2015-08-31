require 'plane'

describe Plane do
	it 'must be flying when initiated' do
		expect(subject).to be_flying
	end

	it 'must not be flying when told to land' do
		subject.land
		expect(subject).to_not be_flying
	end

	it 'must be flying when told to take off' do
		subject.take_off
		expect(subject).to be_flying
	end
end
