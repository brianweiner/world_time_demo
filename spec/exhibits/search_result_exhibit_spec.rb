require 'rails_helper'
require 'rspec/its'

describe SearchResultExhibit do
  subject { SearchResultExhibit.new(search_result, context) }

  let(:search_result) { double(:search_result) }
  let(:context) { double(:context) }
  let(:current_time) { Time.new(2016, 1, 10, 10, 0, 0) }
  let(:timezone) { double(:timezone) }

  before do
    allow(search_result).
      to receive(:city).
      and_return('Baltimore')
    allow(search_result).
      to receive(:state).
      and_return('MD')      
    allow(search_result).
      to receive(:country).
      and_return('United States')
    allow(search_result).
      to receive(:latitude).
      and_return(100)
    allow(search_result).
      to receive(:longitude).
      and_return(100)

    allow(Timezone).
      to receive(:lookup).
      with(100,100). 
      and_return(timezone)
    allow(timezone).
      to receive(:time_with_offset).
      and_return(current_time)
    allow(timezone).
      to receive(:dst?).
      and_return(false)   

    allow(Time).
      to receive(:now).
      and_return(current_time)
  end

  its(:full_name) { should eq('Baltimore, MD - United States') }
  its(:local_time) { should eq('Jan 10, 2016 10:00:00 am') }
  it "returns nil when the current timezone is not observing dst" do
    expect(subject.dst_icon(context)).to be(nil)
  end

  context "dst_icon during dst" do
    before do
      allow(timezone).
        to receive(:dst?).
        and_return(true)
      allow(context).
        to receive(:render).
        and_return(:dst_icon)
    end   
    it "returns an icon when observing dst" do 
      expect(subject.dst_icon(context)).to be(:dst_icon)
    end
  end
end