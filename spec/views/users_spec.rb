require 'spec_helper'

describe "users/show" do
  it "renders _event partial for each event" do
    assign(:user, stub_model(User))
    render
    expect(view).to render_template(:partial => "_event", :count => 0)
  end
end

