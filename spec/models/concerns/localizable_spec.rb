require 'spec_helper_no_rails'
require 'concerns/localizable'
require 'oauth_credentials'
require 'foursquare2'

vcr_options = { cassette_name: 'foursquare/venues', record: :new_episodes }
describe Localizable, vcr: vcr_options do

  before(:all) do
    subject_class.any_instance.stubs(:v_parameter).returns('20130225')
  end

  let(:subject_class) { Class.new.send :include, Localizable }
  subject(:subject_instance) { subject_class.new }

  it { should respond_to(:locate) }
  it { should respond_to(:client) }

  describe '#locate' do

    it 'should find the H.M.S' do
      subject_instance.locate(44.83232, -0.57290).name.should match(/h\.?m\.?s/i)
    end

    it 'should find the fitz patrick' do
      subject_instance.locate(43.60834, 3.87645).name.should match(/fitz/i)
    end

    it 'should find titi twister' do
      subject_instance.locate(44.83175, -0.56979).name.should match(/titi/i)
    end

    it 'should find les furieux' do
      subject_instance.locate(48.85589, 2.37525).name.should match(/furieux/i)
    end
  end

end

