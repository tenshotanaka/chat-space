require 'rails_helper'

describe MessagesController do
  describe "when user signed in" do
    before :each do
      sign_in user
    end

    let(:group) { create(:group, users: [user]) }
    let(:message) { create(:message, user: user, group: group) }
    let(:user) { create(:user) }

    describe ' GET #index ' do
      let(:request) { get :index, group_id: group }
      it "assigns the requested group to @group" do
        request
        expect(assigns(:group)).to eq(group)
      end

      it "assigns the requested groups to @groups" do
        groups = create_list(:group, 3, users: [user])
        get :index, group_id: groups.first
        expect(assigns(:groups)).to eq(groups)
      end

      it "assigns the requested users to @users" do
        users = create_list(:user, 3, groups: [group])
        request
        expect(assigns(:users)).to eq([user] + users)
      end

      it "assigns the requested messages to @messages" do
        messages = create_list(:message, 3, group: group, user: user)
        request
        expect(assigns(:messages)).to eq(messages)
      end

      it "assigns the requested message to @message" do
        request
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "renders the :index template" do
        request
        expect(response).to render_template :index
      end
    end

    describe ' POST #create ' do
      it "assigns the requested message to @message" do
        get :index, group_id: group
        expect(assigns(:message)).to be_a_new(Message)
      end
      
      context "with valid attributes" do
        let(:request) { post :create, group_id: group, message: attributes_for(:message) }
        it 'message was created succesufully' do
          expect{ request }.to change(Message, :count).by(1)
        end

        it "redirect_to the index" do
          request
          expect(response).to redirect_to group_messages_path(group)
        end

        it "show flash[:notice] message" do
          request
          expect(flash[:notice]).to eq ( "you created message" )
        end
      end
      
      context "with invalid attributes" do
        let(:request) { post :create, group_id: group, message: attributes_for(:message ,body: nil) }
        it 'message was created succesufully' do
          expect{ request }.to change(Message, :count).by(0)
        end

        it "redirect_to the index" do
          request
          expect(response).to redirect_to group_messages_path(group)
        end

        it "show flash[:notice] message" do
          request
          expect(flash[:notice]).to eq ( "please create again" )
        end
      end
    end
  end

  describe "when sign out user" do
    it "redirect to /users/sign_in" do
      group = create(:group)
      get :index, group_id: group
      expect(response).to redirect_to new_user_session_path
    end
  end
end
