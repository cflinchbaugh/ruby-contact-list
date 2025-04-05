class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /contacts
  def index
    @page_size = 5
    @tags = Tag.all

    @contacts = Contact.includes(:user, :tags)

    if params[:mine].present?
      # Show only the current user's contacts
      @contacts = @contacts.where(user: current_user)
    else
      # Show all public contacts + current user's private ones
      @contacts = @contacts.where("is_public = ? OR user_id = ?", true, current_user.id)
    end

    # Search by name
    if params[:search].present?
      query = "%#{params[:search]}%"
      @contacts = @contacts.where("first_name LIKE ? OR last_name LIKE ?", query, query)
    end

    # Filter by tag
    if params[:tag_ids].present?
      @contacts = @contacts.joins(:tags).where(tags: { id: params[:tag_ids] }).distinct
    end

    @contacts = @contacts.page(params[:page]).per(@page_size)
  end

  # GET /contacts/1
  def show
    unless @contact.is_public || @contact.user == current_user
      redirect_to contacts_path, alert: "You are not authorized to view this contact."
    end
  end

  # GET /contacts/new
  def new
    @contact = current_user.contacts.build
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.build(contact_params)

    respond_to do |format|
      if @contact.save
        flash[:success] = "Contact was successfully created."
        format.html { redirect_to @contact }
        format.json { render :show, status: :created, location: @contact }
      else
        flash[:error] = "There was an issue creating the contact."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        flash[:success] = "Contact was successfully updated."
        format.html { redirect_to @contact }
        format.json { render :show, status: :ok, location: @contact }
      else
        flash[:error] = "There was an issue updating the contact."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  def destroy
    if @contact.destroy
      flash[:alert] = "Contact was successfully deleted."
    else
      flash[:error] = "There was an issue deleting the contact."
    end

    respond_to do |format|
      format.html { redirect_to contacts_path, status: :see_other }
      format.json { head :no_content }
    end
  rescue StandardError => e
    flash[:error] = "Error deleting contact: #{e.message}"
    redirect_to contacts_path, status: :see_other
  end

  def correct_user
    @contact = current_user.contacts.find_by(id: params[:id])
    redirect_to contacts_path, notice: "Not authorized" if @contact.nil?
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :profile_image,
        :is_public,
        tag_ids: []
      )
    end
end
