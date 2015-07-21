require 'rails_helper'

RSpec.describe Goal, :type => :model do

    # unit test associations and validations with shoulda-matchers
    it { should belong_to(:user) }

end
