require 'spec_helper'

describe Contact do
	describe 'Associations' do
		it { should belong_to :user }
		it { should belong_to :identity }
	end
end
