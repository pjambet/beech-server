require 'spec_helper'

describe Beer do
  it { should belong_to :beer_color }
  it { should belong_to :brewery }
  it { should have_many :checks }
  it { should have_many(:users).through(:checks) }
  it { described_class.should respond_to :search_for}

  it { should act_as_searchable }
  it { should act_as_pageable }

  it { should validate_presence_of(:name) }

  context 'new instance' do
    subject { create :beer }

    its(:background_color) { should_not be_nil }
    its(:font_color) { should_not be_nil }
  end
end
