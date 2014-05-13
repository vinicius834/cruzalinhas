require 'spec_helper'
require 'sp_trans_parser'

describe SPTransParser do
  let(:index_file) { 'spec/fixtures/html/sptrans-index.html' }
  let(:index_html) { File.open(index_file, 'rb') { |file| file.read } }

  let(:sample_route) {
    {
      :number => '9008-21',
      :from   => 'T.T.V.N.CACHOEIRINHA',
      :to     => 'CONJ. HAB. YADOIA'
    }

  }
  let(:sample_route_id) { 78208 }

  let(:route_with_accents) {
    {
      :number => '1767-10',
      :from   => 'METRÔ TUCURUVI',
      :to     => 'EDU CHAVES'
    }
  }
  let(:route_with_accents_id) { 86406 }

  let(:subway_route) {
    {
      :number => 'METRÔ L3-0',
      :from   => 'CORINTHIANS - ITAQUERA',
      :to     => 'PALMEIRAS - BARRA FUNDA'
    }
  }
  let(:subway_route_id) { 12967 }

  describe '#parse_index' do
    let(:routes) { subject.parse_index index_html }

    it 'extracts all routes from an SPTrans index page' do
      routes.count.should == 1291
    end

    it 'correctly parses route internal ID, number and name' do
      routes[sample_route_id].should == sample_route
    end

    it 'deals with non-ASCII chars' do
      routes[route_with_accents_id].should == route_with_accents
    end

    it 'parses subway routes' do
      routes[subway_route_id].should == subway_route
    end

    it 'works fine with either filename or html contents' do
      subject.parse_index(index_html).should == subject.parse_index(index_file)
    end
  end
end
