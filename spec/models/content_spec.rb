require 'rails_helper'
require 'support/models/valid'

RSpec.shared_examples 'media' do |type|
  context "of #{type.capitalize} type" do
    subject { build_stubbed "#{type}_content" }

    include_examples 'valid'

    it 'is not valid without media' do
      subject.media = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without purchasable' do
      subject.purchasable = nil
      expect(subject).to_not be_valid
    end
  end
end

RSpec.describe Content do
  include_examples 'media', :movie
  include_examples 'media', :season
  include_examples 'media', :episode
end
