class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :ensure_admin, only: [:index, :edit, :update, :destroy, :show]

  def index
    @donations = Donation.all
  end

  def show
  end

  def new
    @donation = Donation.new(donation_params)
    @client_token = Braintree::ClientToken.generate
  end

  def edit
  end

  def create
    @result = Braintree::Transaction.sale(
        :amount => params[:donation][:amount].gsub('$', ''),
        :payment_method_nonce => params[:payment_method_nonce],
        :options => {
          :submit_for_settlement => true
        }
      )
    @donation = Donation.new(donation_params)
    raise @result.errors.inspect unless @result.success?
    respond_to do |format|
      if @result.success? && @donation.save
        if current_user
          current_user.braintree_last_4               = @result.transaction.credit_card_details.last_4
          current_user.braintree_payment_method_token = @result.transaction.credit_card_details.token
          current_user.save
        end
        format.html { redirect_to @donation.need, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(:amount, :need_id, :user_id, :number, :cvv, :month, :year, :payment_method_nonce)
    end
end
