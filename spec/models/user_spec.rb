require 'spec_helper'

describe User do
	describe 'Associations' do
		it { should have_many :contacts }
		it { should have_many :identities }
	end
end
