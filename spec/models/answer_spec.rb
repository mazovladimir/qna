require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_many(:attachments) }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(10) }
  it { should accept_nested_attributes_for(:attachments) }
end
