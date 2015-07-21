require 'rails_helper'

RSpec.describe User, :type => :model do
  # unit test associations and validations with shoulda-matchers
  it { should have_many(:goals) }
end
