class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :hide]

    def show
    end

    def index
        if params[:letter]
            @contacts = Contact.name_search(params[:letter])
        else
            @contacts = Contact.order('lastname, firstname')
        end
    end

    def new
        @contact = Contact.new
        %w(home office mobile).each do |phone|
          @contact.phones.build(phone_type: phone)
        end
    end

    def edit
    end

    def create
        @contact = Contact.new(contact_params)

        respond_to do |format|
            if @contact.save
                format.html { redirect_to @contact, notice: 'contact was saved' }
                format.json { render action: 'show', status: :created, location: @contact}
            else
                format.html { render action: 'new' }
                format.json { render json: @contact.errors, status: :unprocessable_entity}
            end
        end
    end

    def update
        respond_to do |format|
            if @contact.update(contact_params)
                format.html { redirect_to @contact, notice: 'The contact was updated'}
                format.json { head :no_content}
            else
                format.html { render action: 'edit' }
                format.json { render json: @contact.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @contact.destroy
        respond_to do |format|
            format.html { redirect_to contacts_url }
            format.json { head :no_content }
        end
    end

    def hide
      @contact.update({hidden: params[:hidden]})
        respond_to do |format|
            format.html { redirect_to contacts_url, notice: 'the contact was hidden'}
            format.json { head :no_content }
        end
    end

    private

    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:firstname, :lastname, :email, :phones_attributes => [:id, :phone, :phone_type])
    end
end
