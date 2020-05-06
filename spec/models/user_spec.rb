require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build_stubbed :user }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with invalid email' do
    subject.email = 'test'
    expect(subject).to_not be_valid
  end
end
