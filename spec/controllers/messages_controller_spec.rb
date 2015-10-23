require 'rails_helper'
RSpec.describe MessagesController, type: :controller do
  before(:each) { sign_in admin_user }

  let!(:user){ FactoryGirl.create(:user) }
  let!(:admin_user){ FactoryGirl.create(:admin_user) }
  let!(:message){ FactoryGirl.create(:message) }

  describe "GET #index" do
    it "assigns all messages as @messages" do
      get :index, {}
      expect(assigns(:messages)).to eq([message])
    end
  end

  describe "GET #show" do
    it "assigns the requested message as @message" do
      get :show, {:id => message.to_param}
      expect(assigns(:message)).to eq(message)
    end
  end

  describe "GET #new" do
    it "assigns a new message as @message" do
      get :new, {}
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  describe "GET #edit" do
    it "assigns the requested message as @message" do
      get :edit, {:id => message.to_param}
      expect(assigns(:message)).to eq(message)
    end
  end

  describe "POST #create" do
    let(:valid_message_params) {
      {
        message: attributes_for(:message, need_id: Need.first.id, user_id: User.first.id ),
        payment_method_nonce: "fake-valid-nonce"        
      }
    }

    let(:invalid_message_params) {
      {
        message: attributes_for(:message, need_id: Need.first.id, user_id: User.first.id, body: 12  ),
        payment_method_nonce: "fake-valid-nonce"        
      }
    }

    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, valid_message_params
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, valid_message_params
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end

      it "redirects to the created message" do
        post :create, valid_message_params
        expect(response).to redirect_to(Message.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        post :create, {:message => invalid_message_attributes}
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        post :create, {:message => invalid_message_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {body: "new body"}
      }

      it "updates the requested message" do
        put :update, {:id => message.to_param, :message => new_attributes}
        message.reload
        expect(Message.last.body).to eq(new_attributes[:body])
      end

      it "assigns the requested message as @message" do
          put :update, {:id => message.to_param, :message => valid_attributes}
        expect(assigns(:message)).to eq(message)
      end

      it "redirects to the message" do
          put :update, {:id => message.to_param, :message => valid_attributes}
        expect(response).to redirect_to(message)
      end
    end

    context "with invalid params" do
      it "assigns the message as @message" do
          put :update, {:id => message.to_param, :message => invalid_attributes}
        expect(assigns(:message)).to eq(message)
      end

      it "re-renders the 'edit' template" do
          put :update, {:id => message.to_param, :message => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested message" do
      expect {
        delete :destroy, {:id => message.to_param}
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      delete :destroy, {:id => message.to_param}
      expect(response).to redirect_to(messages_url)
    end
  end

end
