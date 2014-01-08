require 'spec_helper'

describe Note do
  	describe 'Associations' do
		it { should belong_to :contact }
	end
end
