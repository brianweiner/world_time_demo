require 'rails_helper'
require 'rspec/its'

describe SearchResultExhibit do
  subject { SearchResultExhibit.new(search_result, context) }

  let(:search_result) { double(:search_result) }
  let(:context) { double(:context) }
  let(:current_time) { Time.new(2016, 1, 10, 10, 0, 0) }
  let(:timezone) { double(:timezone) }
  let(:wikipedia) { double(:wikipedia) }

  before do
    allow(search_result).
      to receive(:city).
      and_return('Baltimore')
    allow(search_result).
      to receive(:state).
      and_return('Maryland')      
    allow(search_result).
      to receive(:country).
      and_return('United States')
    allow(search_result).
      to receive(:search_term).
      and_return('Camden Yards')
    allow(search_result).
      to receive(:latitude).
      and_return(100)
    allow(search_result).
      to receive(:longitude).
      and_return(100)
    allow(search_result).
      to receive(:city_wiki_url).
      and_return(:city_wiki_url)
    allow(search_result).
      to receive(:country_wiki_url).
      and_return(:country_wiki_url)
    allow(search_result).
      to receive(:state_wiki_url).
      and_return(:state_wiki_url)
    allow(search_result).
      to receive(:search_term_wiki_url).
      and_return(:search_term_wiki_url)
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
    allow(timezone).
      to receive(:name).
      and_return('America/New_York')  

    allow(Time).
      to receive(:now).
      and_return(current_time)
  end

  its(:local_time) { should eq('Jan 10, 2016 10:00am') }
  its(:timezone_name) { should eq('America/New York') }
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

  describe "link methods" do
    before do
      allow(WikipediaFinder).
        to receive(:new).
        and_return(wikipedia)
    end

    context "#city_link" do
      before do
        allow(context).
          to receive(:link_to).
          with("Baltimore", :city_wiki_url, {:target=>"_blank"}).
          and_return(:city_link)
      end

      it "returns the wiki url" do
        expect(subject.city_link(context)).to eq(:city_link)
      end
    end

    context "#state_link" do
      before do
        allow(context).
          to receive(:link_to).
          with("Maryland", :state_wiki_url, {:target=>"_blank"}).
          and_return(:state_link)
      end

      it "returns the wiki url" do
        expect(subject.state_link(context)).to eq(:state_link)
      end
    end

    context "#country_link" do
      before do
        allow(context).
          to receive(:link_to).
          with("United States", :country_wiki_url, {:target=>"_blank"}).
          and_return(:country_link)
      end

      it "returns the wiki url" do
        expect(subject.country_link(context)).to eq(:country_link)
      end
    end

    context "#search_term_link" do
      before do
        allow(context).
          to receive(:link_to).
          with("Camden Yards", :search_term_wiki_url, {:target=>"_blank"}).
          and_return(:search_term_link)
      end

      it "returns the wiki url" do
        expect(subject.search_term_link(context)).to eq(:search_term_link)
      end
    end
  end
end