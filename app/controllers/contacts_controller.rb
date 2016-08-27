 class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:new,:create]

    # GET /contacts
    # GET /contacts.json
    def index
        @contacts = Contact.all
        authorize @contacts
    end

    # GET /contacts/1
    # GET /contacts/1.json
    def show
        authorize @contact
    end

    # GET /contacts/new
    def new
        @contact = Contact.new
    end

    # GET /contacts/1/edit
    def edit
        authorize @contact
    end

    # POST /contacts
    # POST /contacts.json
    def create
        @contact = Contact.new(contact_params)

        respond_to do |format|
            if verify_recaptcha(model: @contact) && @contact.save
                format.html { redirect_to new_contact_path, notice: 'Contact was successfully created.' }
                format.json { render :show, status: :created, location: @contact }
            else
                format.html { render :new }
                format.json { render json: @contact.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /contacts/1
    # PATCH/PUT /contacts/1.json
    def update
        authorize @contact
        respond_to do |format|
            if @contact.update(contact_params)
                format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
                format.json { render :show, status: :ok, location: @contact }
            else
                format.html { render :edit }
                format.json { render json: @contact.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /contacts/1
    # DELETE /contacts/1.json
    def destroy
        authorize @contact
        @contact.destroy
        respond_to do |format|
            format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
        @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
        params.require(:contact).permit(:name, :email, :obs)
    end
end
