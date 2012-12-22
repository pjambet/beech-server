require 'spec_helper'

describe Role do
  it { should have_many(:memberships) }
  it { should have_many(:users).through(:memberships) }

  context 'with a new instance' do
    subject { create :role }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe ".admin_role" do
    context "when role doesn't exist" do
      it 'should create the role' do
        expect { Role.admin_role }.to change{ Role.count }.by(1)
      end

      it 'should return the admin role' do
        admin_role = Role.admin_role
        admin_role.should be_persisted
        admin_role.name.should == 'admin'
      end

    end

    context "when role already exists" do
      before(:each) { Role.admin_role }

      it 'should not create the role' do
        expect { Role.admin_role }.to change{ Role.count }.by(0)
      end

      it 'should return the admin role' do
        admin_role = Role.admin_role
        admin_role.should be_persisted
        admin_role.name.should == 'admin'
      end
    end
  end
end
