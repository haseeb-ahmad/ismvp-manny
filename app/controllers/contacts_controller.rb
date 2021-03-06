class ContactsController < ApplicationController
	before_action :set_contact, only: [:show, :edit, :update, :destroy]
	before_action :get_user
	before_filter :authenticate_user!

	# GET /contacts
	# GET /contacts.json
	def index
		@contacts = current_user.contacts.get_active_contacts
	end

	# GET /contacts/1
	# GET /contacts/1.json
	def show
	end

	# GET /contacts/new
	def new
		@contact = Contact.new
	end

	# GET /contacts/1/edit
	def edit
	end

	# POST /contacts
	# POST /contacts.json
	def create
		@contact = Contact.new(contact_params)

		respond_to do |format|
			if @contact.save
				format.html { redirect_to user_contacts_path, notice: 'Contact was successfully created.' }
				format.json { render action: 'show', status: :created, location: @contact }
			else
				format.html { render :action => "new" }
				format.json { render json: @contact.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /contacts/1
	# PATCH/PUT /contacts/1.json
	def update
		respond_to do |format|
			if @contact.update(contact_params)
				format.html { redirect_to user_contact_path, notice: 'Contact was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @contact.errors, status: :unprocessable_entity }
			end
		end
	end

	# Soft Delete	
	def destroy
		@contact.is_deleted = true
		@contact.save!
		redirect_to user_contacts_path
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_contact
			@contact = Contact.find(params[:id])
		end

		def get_user
			@user = current_user
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def contact_params
			params.require(:contact).permit(:full_name, :first_name, :last_name, :given_name, :photo_url, :gender, :email, :phone, :user_id, :identity_id, :network_url, :network_username, :job_title, :organization, :industry, :country, :about, :notes, :education, :work).merge(:user_id => params[:user_id])
		end
end
