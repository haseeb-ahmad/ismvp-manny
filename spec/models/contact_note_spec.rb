require 'spec_helper'

describe ContactNote do
  	describe 'Associations' do
		it { should belong_to :contact }
	end
end
