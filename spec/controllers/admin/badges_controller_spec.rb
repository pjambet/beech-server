require 'spec_helper'

describe Admin::BadgesController do
  render_views

  it_should_behave_like 'an admin controller', {
    index: :get,
    new: :get,
    create: :post,
    edit: {method: :get, params: {id: 1}},
    update: {method: :put, params: {id: 1}},
    destroy: {method: :delete, params: {id: 1}},
  }
end

