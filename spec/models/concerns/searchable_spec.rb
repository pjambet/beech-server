require 'spec_helper'

describe Searchable do

  context 'Models' do

    let(:dummy_class) do
      Class.new(ActiveRecord::Base) do
        include Searchable::Models
        searchable_by "dummy"
      end
    end

    describe '#search_for' do
      it 'should respond to search_for' do
        dummy_class.should respond_to(:search_for)
      end
    end
  end
end

