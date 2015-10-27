class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_donor!

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @donation = Donation.new(donation_params)
    @client_token = Braintree::ClientToken.generate
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
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
        if current_donor
          current_donor.braintree_last_4               = @result.transaction.credit_card_details.last_4
          current_donor.braintree_payment_method_token = @result.transaction.credit_card_details.token
          current_donor.save
        end

        format.html { redirect_to @donation.need, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
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

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:amount, :need_id, :donor_id, :number, :cvv, :month, :year, :payment_method_nonce)
    end
end
