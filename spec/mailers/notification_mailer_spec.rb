require 'spec_helper'

shared_examples "default recipients" do
  context 'without any environment variable defined' do
    it 'should send the mail to contact@getbeech.com' do
      mail.to.should == ['contact@getbeech.com']
    end
  end

  context 'with an environment var defined' do
    before(:all) do
      ENV.stubs(:[]).returns('p.j@g.c,lulu@foo.com')
    end
    it 'should send the mail to contact@getbeech.com' do
      mail.to.should == ['p.j@g.c', 'lulu@foo.com']
    end
  end
end

describe NotificationMailer do
  describe 'new_beer' do
    let(:user) { create :user }
    let(:beer) { create :beer, added_by: user }
    let(:mail) { NotificationMailer.new_beer(beer) }


    it 'should assign the beer' do
      mail.body.encoded.should match(user.nickname)
    end

    it 'should include the beer name in the mail' do
      mail.body.encoded.should match(beer.name)
    end

    include_examples "default recipients"
  end

  describe 'new_user' do
    let(:user) { create :user }
    let(:mail) { NotificationMailer.new_user(user) }


    it 'should assign the user' do
      mail.body.encoded.should match(user.nickname)
    end

    include_examples "default recipients"
  end

  describe 'accepted_beer' do
    let(:user) { create :user }
    let(:beer) { create :beer, added_by: user }
    let(:mail) { NotificationMailer.accepted_beer(beer) }


    it 'should assign the beer' do
      mail.body.encoded.should match(user.nickname)
    end

    it 'should include the username in the mail' do
      mail.body.encoded.should match(beer.name)
    end

    it 'should send the mail to the author of the beer' do
      mail.to.should == [beer.added_by.email]
    end

  end
end
