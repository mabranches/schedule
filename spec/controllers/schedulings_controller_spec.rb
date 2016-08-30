require 'rails_helper'

RSpec.describe SchedulingsController, type: :controller do
  render_views
  before do
    @user = User.create(name:'user', email:'email@test.com')#, password:'123', pas)
  end
  let(:scheduling_attributes) {
    {
      day: '2016-08-24',
      hour: 10
    }
  }


  describe "GET #index" do
    before do
      zone = Time.zone
      allow(zone).to receive(:today){  Date.parse('2016-08-24') }
      allow(Time).to receive(:zone){ zone }
      monday =  Date.parse('2016-08-22')
      friday =  Date.parse('2016-08-26')
      10.times do
        result = false
        while(!result) do
          day = rand(monday..friday)
          hour = rand(CONFIG['hour']['start']..CONFIG['hour']['end'])
          result = Scheduling.create(day: day, hour: hour, user_id: @user.id).valid?
        end
      end
      sign_in @user
    end

    it 'should render all schedulings' do
      #expect {get :index}.to make_database_queries(count: 3)
      get :index
      expect(response.body).to have_css('div.busy', count: 10)
      expect(response).to have_http_status(:ok)
      Scheduling.all.each do |s|
         expect(response.body).to have_xpath("//td/div[@data-scheduling-id=#{s.id}]")
      end
    end
  end

  describe "POST #create" do
    context 'unauthenticated user' do
      it 'should redirect to login page' do
        expect { post :create, params: { scheduling: scheduling_attributes }}.
          to make_database_queries(count: 0)
        expect(response).to have_http_status(:redirect)
        expect(response.location).to end_with('users/sign_in')
      end
    end

    context 'authenticated user' do
      before do
        sign_in @user
        Scheduling.create(scheduling_attributes.merge(user_id:@user.id))
      end

      context 'try to schedule previously scheduled time' do
        it 'should issue an error' do
          expect { post :create, params: { scheduling: scheduling_attributes } }.
            to make_database_queries(count: 4)
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['errors']).to include(
            {"title"=>"hour", "message"=>"has already been taken"})
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context 'try to cancel an scheduling of other user' do
      before do
        new_user = User.create(name:'user2', email:'user2@test.com')
        @scheduling = Scheduling.create(scheduling_attributes.merge(user_id:@user.id))
        sign_in new_user
      end

      it 'should issue an error' do
        expect { delete :destroy, params:{ id: @scheduling.id } }.
          to make_database_queries(count: 2)
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)

        expect(body['errors']).to include(
          {"title"=>"user", "message"=>"current user is not owner."})

      end

    end
  end

end
