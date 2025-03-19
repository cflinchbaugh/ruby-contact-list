class ContactsController < ApplicationController
  before_action :authenticate_user!  # Require authentication for all actions
  before_action :set_contact, only: %i[show edit update destroy]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

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

  # PATCH/PUT /contacts/1 or /contacts/1.json
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

  # DELETE /contacts/1 or /contacts/1.json
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

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, :user_id)
    end
end
