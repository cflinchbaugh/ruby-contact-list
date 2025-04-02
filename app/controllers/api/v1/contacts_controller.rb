module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_contact, only: [ :show, :update, :destroy ]

      def index
        contacts = current_user.contacts
        render json: contacts
      end

      def show
        render json: @contact
      end

      def create
        contact = current_user.contacts.build(contact_params)
        if contact.save
          render json: contact, status: :created
        else
          render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @contact.update(contact_params)
          render json: @contact
        else
          render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @contact.destroy
        head :no_content
      end

      private

      def set_contact
        @contact = current_user.contacts.find(params[:id])
      end

      def contact_params
        params.require(:contact).permit(
          :first_name, :last_name, :email, :phone, :profile_image, tag_ids: []
        )
      end
    end
  end
end
