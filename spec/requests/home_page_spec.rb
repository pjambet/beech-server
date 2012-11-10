require 'spec_helper'

describe "home page" do
  it "displays the user's username after successful login" do
    user = User.create!(email: "jdoe@gmail.com", password: "secret")
    get "/users/sign_in"
    assert_select "form.new_user" do
      assert_select "input[name=?]", "user[email]"
      assert_select "input[name=?]", "user[password]"
      assert_select "input[type=?]", "submit"
    end

    post "/users/sign_in", email: "jdoe@gmail.com", password: "secret"
    assert_select "header", text: "jdoe@gmail.com"
  end
end
