class NeedsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

  before_action :redirect_to_newest_url # <-- this line FIRST !
  load_resource :find_by => :slug, :only => [:show]
  load_and_authorize_resource :find_by => :slug, :except => [:show, :index] # <-- and then this line

  # GET /needs
  # GET /needs.json
  def index
    @needs = current_organization.needs.all
  end

  # GET /needs/1
  # GET /needs/1.json
  def show
    @donation = @need.donations.build
  end

  # GET /needs/new
  def new
    @need = current_organization.needs.build
  end

  # GET /needs/1/edit
  def edit
  end

  # POST /needs
  # POST /needs.json
  def create
    @need = current_organization.needs.build(need_params)
    @need.user = current_user

    respond_to do |format|
      if @need.save
        format.html { redirect_to @need, notice: 'Need was successfully created.' }
        format.json { render :show, status: :created, location: @need }
      else
        format.html { render :new }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /needs/1
  # PATCH/PUT /needs/1.json
  def update
    respond_to do |format|
      if @need.update(need_params)
        format.html { redirect_to @need, notice: 'Need was successfully updated.' }
        format.json { render :show, status: :ok, location: @need }
      else
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /needs/1
  # DELETE /needs/1.json
  def destroy
    @need.destroy
    respond_to do |format|
      format.html { redirect_to needs_url, notice: 'Need was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_need
    @need = current_organization.needs.friendly.find(params[:id])
  end

  def need_params
    params.require(:need).permit(:title, :posted_at, :description, :amount_requested, :slug)
  end

  def redirect_to_newest_url
    @need = Need.find_by_id(params[:id])

    if @need && request.path != need_path(@need)
      return redirect_to @need, :status => :moved_permanently
    end
  end

end
