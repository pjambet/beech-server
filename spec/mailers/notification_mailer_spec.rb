require 'spec_helper'

describe NotificationMailer do
  describe 'new_beer' do
    let(:user) { create :user }
    let(:beer) { create :beer, added_by: user }
    let(:mail) { NotificationMailer.new_beer(beer) }


    it 'should assign the beer' do
      mail.body.encoded.should match(user.nickname)
    end

    it 'should include the username in the mail' do
      mail.body.encoded.should match(beer.name)
    end

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
end
