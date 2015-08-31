require 'airport'

describe Airport do
	it 'must allow planes to land' do
		expect(subject).to respond_to :land_plane
	end

	it 'must allow planes to land' do
		plane = double :plane, flying?:true
		weather = double :weather, Stormy?: false
		allow(plane).to receive(:land){plane = double :plane, flying?: false}
		expect(subject.land_plane plane, weather).to eq subject.planes
	end

	it 'accepts planes and stores them' do
		plane = double :plane
		weather = double :weather, Stormy?: false
		allow(plane).to receive(:land)
		expect{subject.land_plane plane, weather}.to change{ subject.planes.length }.by(1)
	end

	it 'must send land commpand to plane' do
		plane = double :plane, flying?: true
		weather = double :weather, Stormy?: false
		expect(plane).to receive(:land)
		subject.land_plane plane, weather
	end

	it 'must allow planes to take off' do
		expect(subject).to respond_to :take_off
	end

	it 'must send take_off commpand to plane' do
		plane = double :plane, flying?: true
		weather = double :weather, Stormy?: false
		allow(plane).to receive(:land)
		subject.land_plane plane, weather
		expect(plane).to receive(:take_off)
		subject.take_off weather
	end

	it 'must have a default capacity of 20 planes.' do
		expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
	end

	it 'cannot accept anymore planes planes if the airport is at full capacity' do
	plane = double :plane
	weather = double :weather, Stormy?: false
	allow(plane).to receive(:land)
	20.times do
		(subject.land_plane plane,weather)
	end
	expect{subject.land_plane plane, weather}.to raise_error "Airport Full"
	end

	it 'cannot release planes if the airport is empty' do
		plane = double :plane, flying?:false
		allow(plane).to receive(:take_off)
		expect{subject.take_off}.to raise_error "There are no Planes"
	end

	it 'cannot land planes when the weather is Stormy' do
		plane = double :plane
		allow(plane).to receive(:land)
		weather = double :weather, Stormy?: true
		expect(subject.land_plane plane, weather).to eq "The storm has made it impossible to land"
	end

	it 'must not accept anymore planes in stormy weather' do
	weather = double :weather, Stormy?:true
	plane = double :plane
	allow(plane).to receive(:land)
	subject.land_plane plane, weather
	expect{subject.land_plane plane, weather}.to change{subject.planes.length}.by(0)
end

	it 'cannot release plane when the weather is Stormy and will raise error' do
		plane = double :plane
		weather = double :weather, Stormy?:false
		allow(plane).to receive(:land)
		allow(plane).to receive(:take_off)
		subject.land_plane plane, weather
		weather = double :weather, Stormy?:true
		expect(subject.take_off weather).to eq "The Weather is too stormy to take off"
	end

	it 'will keep a plane when the weather is Stormy' do
		plane = double :plane
		weather = double :weather, Stormy?:false
		allow(plane).to receive(:land)
		allow(plane).to receive(:take_off)
		subject.land_plane plane, weather
		weather = double :weather, Stormy?:true
		expect(subject.planes.length).to eq 1
	end


end
