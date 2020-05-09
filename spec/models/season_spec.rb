require 'rails_helper'
require 'support/models/valid'
require 'support/models/metadata'
require 'support/models/index'

RSpec.describe Season do
  subject { build_stubbed :season }

  include_examples 'valid'
  include_examples 'metadata'
  include_examples 'index'
end
