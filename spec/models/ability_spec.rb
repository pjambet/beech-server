require 'spec_helper'

describe Ability do

  subject { ability }
  let(:ability){ Ability.new(user) }
  let(:user){ nil }

  context 'when is a regular user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it{ should_not be_able_to(:manage, :all) }
    it{ should be_able_to(:update, user) }
    it{ should_not be_able_to(:update, other_user) }
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }
    let(:other_user) { create(:user) }

    it{ should be_able_to(:manage, :all) }
    it{ should be_able_to(:update, user) }
    it{ should be_able_to(:update, other_user) }
  end
end
