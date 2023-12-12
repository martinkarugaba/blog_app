require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET /show' do
    it 'renders a successful response' do
      get :show
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end
  end
end
