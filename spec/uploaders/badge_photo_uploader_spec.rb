require 'spec_helper'

describe BadgePhotoUploader do
  include CarrierWave::Test::Matchers

  subject(:uploader) { BadgePhotoUploader.new(user, :avatar) }
  let(:filename) { 'default-avatar-1.png' }
  let(:user) { build(:user) }

  before do
    DateTime.stubs(:now).returns(123456789)
    @current_timestamp = DateTime.now.to_i.to_s
    uploader.store!(File.open("./public/#{filename}"))
  end

  after do
    uploader.remove!
  end

  context 'the thumb version' do
    subject { uploader.thumb }
    it { should be_no_larger_than(100, 100) }
  end

  it { should be_no_larger_than(200, 200) }
  it { should have_permissions(0644) }

end

