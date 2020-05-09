require 'rails_helper'
require 'support/models/valid'

RSpec.describe Purchase do
  subject { build_stubbed :purchase }

  include_examples 'valid'

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a price' do
    subject.price_cents = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a price < 0' do
    subject.price_cents = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid without a currency' do
    subject.price_currency = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a quality' do
    subject.quality = nil
    expect(subject).to_not be_valid
  end
end
