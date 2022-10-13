require 'rails_helper'

RSpec.describe VideosController do
  describe 'GET #index' do
    let!(:video_1) { FactoryBot.create :video, link: 'https://www.youtube.com/watch?v=ZqgiuPt5QZo' }
    let!(:video_2) { FactoryBot.create :video, link: 'https://www.youtube.com/watch?v=HV6h7MRrRNA' }

    before { get :index }

    specify do
      expect(response.response_code).to eq 200
      expect(response).to render_template 'index'
      expect(assigns(:videos)).to match_array [video_1, video_2]
    end
  end

  describe 'GET #new' do
    before { get :new }

    specify do
      expect(response.response_code).to eq 200
      expect(response).to render_template 'new'
    end
  end

  describe 'POST #create' do
    context 'success' do
      let(:params) { { video: { link: 'https://www.youtube.com/watch?v=ZqgiuPt5QZo' } } }

      specify do
        expect do
          post :create, params
        end.to change { Video.count }.by(1)
        expect(response.response_code).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'failure' do
      let(:params) { { video: { link: '123' } } }

      specify do
        expect do
          post :create, params
        end.not_to change { Video.count }
        expect(response.response_code).to eq 200
        expect(response).to render_template 'new'
      end
    end
  end
end
