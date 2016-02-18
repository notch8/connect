class UsersController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def report
    byebug
    user = User.find(params[:user_id])
    if user.has_role?(:admin)
      return admin_csv_report
    else
      return user_csv_report
    end
  end

  private

  def admin_csv_report
    donations = Donation.all
    csv_string = CSV.generate do |csv|
      csv << ["Donor Name", "Donor Email", "Amount", "Braintree Code", "Need Donated To", "User of Need"]

      donations.each do |donation|
        donor = donation.donor
        need  = donation.need
        csv << [donor.name, donor.email, donation.amount.to_s, donor.braintree_last_4, need.name, need.user.name]
      end
    end

    return csv_string
  end

  def user_csv_report
    donations = current_user.needs.map{|need| need.donations}.flatten

    csv_string = CSV.generate do |csv|
      csv << ["Donor Name", "Donor Email", "Braintree Code", "Need Donated to"]

      donations.each do |donation|
        donor = donation.donor
        need  = donation.need
        csv << [donor.name, donor.email, donor.braintree_last_4, need.name]
      end
    end

    return csv_string
  end

  def set_user
    if current_user.has_role?(:admin)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end