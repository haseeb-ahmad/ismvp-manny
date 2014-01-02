class ContactNotesController < ApplicationController
	before_action :set_contact_note, only: [:show, :edit, :update, :destroy]
	before_action :set_user_and_contact

	# GET /contact_notes
	# GET /contact_notes.json
	def index
		@contact_notes = @contact.contact_notes.reverse #ContactNote.all
	end

	# GET /contact_notes/1
	# GET /contact_notes/1.json
	def show
	end

	# GET /contact_notes/new
	def new
		@contact_note = ContactNote.new
	end

	# GET /contact_notes/1/edit
	def edit
	end

	# POST /contact_notes
	# POST /contact_notes.json
	def create
		@contact_note = ContactNote.new(contact_note_params)

		respond_to do |format|
			if @contact_note.save
				format.html { redirect_to user_contact_contact_notes_path, notice: 'Contact note was successfully created.' }
				format.json { render action: 'show', status: :created, location: @contact_note }
			else
				format.html { render action: 'new' }
				format.json { render json: @contact_note.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /contact_notes/1
	# PATCH/PUT /contact_notes/1.json
	def update
		respond_to do |format|
			if @contact_note.update(contact_note_params)
				format.html { redirect_to @contact_note, notice: 'Contact note was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @contact_note.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /contact_notes/1
	# DELETE /contact_notes/1.json
	def destroy
		@contact_note.destroy
		respond_to do |format|
			format.html { redirect_to contact_notes_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_contact_note
			@contact_note = ContactNote.find(params[:id])
		end

		def set_user_and_contact
			@user = User.find(params[:user_id])
			@contact = Contact.find(params[:contact_id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def contact_note_params
			params.require(:contact_note).permit(:note).merge(:contact_id => params[:contact_id])
		end
end
