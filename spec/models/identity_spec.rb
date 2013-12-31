require 'spec_helper'

describe Identity do
	describe 'Associations' do
		it { should have_many :contacts }
		it { should belong_to :user }
	end
end
