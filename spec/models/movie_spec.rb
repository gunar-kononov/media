require 'rails_helper'
require 'support/model/valid'
require 'support/model/metadata'

RSpec.describe Movie, type: :model do
  subject { build_stubbed :movie }

  include_examples 'valid'
  include_examples 'metadata'
end
