require 'rails_helper'
require 'support/model/valid'

RSpec.describe User do
  subject { build_stubbed :user }

  include_examples 'valid'

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with invalid email' do
    subject.email = 'test'
    expect(subject).to_not be_valid
  end
end
