require 'spec_helper'

describe 'routing to journal' do
  it 'routes /api/journal_entries to journal_entries#index' do
    expect(get: '/api/journal_entries').to route_to(
      controller: 'api/journal_entries',
      action: 'index'
    )
  end
end

