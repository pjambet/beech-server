require 'spec_helper'

describe "routing to profiles" do
  it "routes /users/sign_in to sessions#new" do
    expect(get: "/users/sign_in").to route_to(
      controller: "devise/sessions",
      action: "new"
    )
  end

  it "does not expose a list of profiles" do
    expect(get: "/users").not_to be_routable
  end
end

