require 'airport'

describe Airport do

	context 'landing in sunny weather' do

		let(:plane) { double :plane, land: nil }
		let(:weather) { double :weatherman, Stormy?: false }

		it 'must respond to land_plane' do
			expect(subject).to respond_to :land_plane
		end

		it 'must allow planes to land' do
			expect(subject.land_plane plane, weather).to eq subject.planes
		end

		it 'accepts planes and stores them' do
			expect{subject.land_plane plane, weather}.to change{ subject.planes.length }.by(1)
		end

		it 'must send land command to plane' do
			expect(plane).to receive(:land)
			subject.land_plane plane, weather
		end
	end

	context 'taking off in sunny weather' do

		let(:plane) { double :plane, land: nil }
		let(:weather) { double :weatherman, Stormy?: false }

		it 'must allow planes to take off' do
			expect(subject).to respond_to :take_off
		end

		it 'must send take_off commpand to plane' do
			subject.land_plane plane, weather
			expect(plane).to receive(:take_off)
			subject.take_off weather
		end
	end

	context 'full or empty airport' do

		let(:plane) {double :plane, land: nil, take_off: nil}
		let(:weather) {double :weather, Stormy?: false}

		it 'must have a default capacity of 20 planes.' do
			expect(subject.capacity).to eq 20
		end

		it 'cannot accept anymore planes planes if the airport is at full capacity' do
			20.times do
				(subject.land_plane plane,weather)
			end
		expect{subject.land_plane plane, weather}.to raise_error "Airport Full"
		end

		it 'cannot release planes if the airport is empty' do
			expect{subject.take_off}.to raise_error "There are no Planes"
		end
	end

	context 'in stormy weather' do

		let(:plane) {double :plane, land: nil, take_off: nil}
		let(:weather) {double :weather, Stormy?: true}
		let(:calm_weather) {double :weather, Stormy?: false}

		it 'cannot land planes when the weather is Stormy' do
			expect(subject.land_plane plane, weather).to eq "The storm has made it impossible to land"
		end

		it 'must not accept anymore planes in stormy weather' do
		subject.land_plane plane, weather
		expect{subject.land_plane plane, weather}.to change{subject.planes.length}.by(0)
		end

		it 'cannot release plane when the weather is Stormy and will raise error' do
			subject.land_plane plane, calm_weather
			expect(subject.take_off weather).to eq "The Weather is too stormy to take off"
		end

		it 'will keep a plane when the weather is Stormy' do
			subject.land_plane plane, calm_weather
			expect(subject.planes.length).to eq 1
		end
	end

end
