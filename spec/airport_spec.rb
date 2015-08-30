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

	it "Airport Capacity must return a default of capacity of 20." do
		expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
	end

	it "Planes cannot land if the airport is at full capacity" do
	plane=double :plane, flying?: true
	weather = double :weather, Stormy?: false
	allow(plane).to receive(:land){ plane = double :plane, flying?: false}
	20.times do
		(subject.land_plane plane,weather )
		allow(plane).to receive(:land){ plane = double :plane, flying?: false}

	end
	expect{subject.land_plane plane, weather}.to raise_error "Airport Full"
	end

	it "Planes cannot take off if the airport is empty" do
		plane = double :plane, flying?:false
		allow(plane).to receive(:take_off){plane=double :plane, flying?:true}
		expect{subject.take_off}.to raise_error "There are no Planes"
	end

	it "Planes cannot land when the weather is Stormy" do
		plane=double :plane
		allow(plane).to receive(:land){false}
		weather = double :weather, Stormy?: true
		expect(subject.land_plane plane, weather).to eq "The storm has made it impossible to land"
	end

	it "A new airport must be empty after a plane attempts to land in stormy weater" do
	weather=double :weather, Stormy?:true
	plane=double :plane, flying?:true
	allow(plane).to receive(:land){plane=double :plane, flying?:false}
	subject.land_plane plane, weather
	expect(subject.planes).to eq []
end

	it "Plane cannot take off when the weather is Stormy" do
		plane=double :plane, flying?: true
		weather=double :weather, Stormy?:false
		allow(plane).to receive(:land){plane=double :plane, flying?:false}
		allow(plane).to receive(:take_off){plane=double :plane, flying?:true}
		subject.land_plane plane, weather
		weather=double :weather, Stormy?:true
		expect(subject.take_off weather).to eq "The Weather is too stormy to take off"
	end


end
