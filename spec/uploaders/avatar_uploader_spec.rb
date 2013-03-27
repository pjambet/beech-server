require 'spec_helper'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:filename) { 'default-avatar-1.png' }
  let(:user) { build(:user) }
  subject(:uploader) { AvatarUploader.new(user, :avatar) }

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
    it { should be_no_larger_than(68, 68) }
    its(:filename) { should match(@current_timestamp) }
  end

  it { uploader.should have_permissions(0644) }
  its(:filename) { should match(@current_timestamp) }

  context 'with a file without extension' do
    let(:filename) { 'default-avatar' }
    its(:filename) { should match(/jpg$/) }
  end
end
