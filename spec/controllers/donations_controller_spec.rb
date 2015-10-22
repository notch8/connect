require 'rails_helper'
RSpec.describe DonationsController, type: :controller do

  let!(:user){ FactoryGirl.create(:user) }
  let!(:admin_user){ FactoryGirl.create(:admin_user) }
  let!(:donation){ FactoryGirl.create(:donation) }
  let!(:need){ FactoryGirl.create(:need) }

  describe "GET #index" do
    it "assigns all donations as @donations" do
      sign_in admin_user
      FactoryGirl.create(:donation)
      donations = Donation.all
      get :index, {}
      expect(assigns(:donations)).to eq(donations)
    end
  end

  describe "GET #show" do
    it "assigns the requested donation as @donation" do
      donation = FactoryGirl.create(:donation)
      get :show, {:id => donation.to_param}
      expect(assigns(:donation)).to eq(donation)
    end
  end

  describe "GET #new" do
    it "assigns a new donation as @donation" do
      sign_in user
      get :new, {:donation => attributes_for(:donation)}
      expect(assigns(:donation)).to be_a_new(Donation)
    end
  end

  describe "GET #edit" do
    it "assigns the requested donation as @donation" do
      get :edit, {:id => donation.to_param}
      expect(assigns(:donation)).to eq(donation)
    end
  end

  describe "POST #create" do
    before(:each) { sign_in user }

    let(:valid_donation_params) {
      {
        donation: attributes_for(:donation, need_id: Need.first.id ),
        payment_method_nonce: "fake-valid-nonce"        
      }
    }

    let(:invalid_donation_params) {
      {
        donation: attributes_for(:donation, need_id: Need.first.id, amount_requested: "hat" ),
        payment_method_nonce: "fake-valid-nonce"        
      }
    }

    context "with valid params" do

      # this test breaks randomly because Braintree responds with a 422 about half the time.
      it "creates a new Donation" do
        VCR.use_cassette 'successful response' do        
          expect {
            post :create, valid_donation_params
          }.to change(Donation, :count).by(1)
        end
      end

      it "assigns a newly created donation as @donation" do
        VCR.use_cassette 'successful response' do
          post :create, valid_donation_params
          expect(assigns(:donation)).to be_a(Donation)
          expect(assigns(:donation)).to be_persisted          
        end
      end

      it "redirects to the created donation" do
        VCR.use_cassette 'successful response' do
          post :create, valid_donation_params
          expect(response).to redirect_to(Donation.last)
        end
      end
    end

    context "with invalid params" do
      let(:invalid_donation_attributes) { attributes_for(:donation, need_id: Need.first.id, amount_requested: "hat" ) }

      it "assigns a newly created but unsaved donation as @donation" do
        VCR.use_cassette 'successful response' do
          post :create, invalid_donation_params
          expect(assigns(:donation)).to be_a_new(Donation)
        end
      end

      it "re-renders the 'new' template" do
        VCR.use_cassette 'successful response' do
          post :create, invalid_donation_params
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {amount: 1111}
      }

      it "updates the requested donation" do
        put :update, {:id => donation.to_param, :donation => new_attributes}
        donation.reload
        expect (Donation.last.amount).to be(1111)
      end

      it "assigns the requested donation as @donation" do
        put :update, {:id => donation.to_param, :donation => valid_donation_attributes}
        expect(assigns(:donation)).to eq(donation)
      end

      it "redirects to the donation" do
        put :update, {:id => donation.to_param, :donation => valid_donation_attributes}
        expect(response).to redirect_to(donation)
      end
    end

    context "with invalid params" do
      it "assigns the donation as @donation" do
        put :update, {:id => donation.to_param, :donation => invalid_donation_attributes}
        expect(assigns(:donation)).to eq(donation)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => donation.to_param, :donation => invalid_donation_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested donation" do
      expect {
        delete :destroy, {:id => donation.to_param}
      }.to change(Donation, :count).by(-1)
    end

    it "redirects to the donations list" do
      delete :destroy, {:id => donation.to_param}
      expect(response).to redirect_to(donations_url)
    end
  end

end
