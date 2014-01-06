require 'spec_helper'

describe Contact do
	let(:contact) { FactoryGirl.create(:contact) }

	describe 'Associations' do
		it { should belong_to :user }
		it { should belong_to :identity }
		it { should have_many :contact_notes }
	end

	context "validations" do
		it "should require a full name" do
			contact.full_name = ""
			contact.should_not be_valid
		end
	end
end
