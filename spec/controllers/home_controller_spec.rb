require 'spec_helper'

describe HomeController do
  describe "GET index" do

    it "assigns all widgets to @widgets" do
      get :index
      expect(response).to render_template('home/index')
    end
  end
end
