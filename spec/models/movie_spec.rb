require 'rails_helper'
require 'support/models/valid'
require 'support/models/metadata'

RSpec.describe Movie do
  subject { build_stubbed :movie }

  include_examples 'valid'
  include_examples 'metadata'
end
