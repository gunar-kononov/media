require 'rails_helper'
require 'support/model/valid'
require 'support/model/metadata'
require 'support/model/index'

RSpec.describe Season do
  subject { build_stubbed :season }

  include_examples 'valid'
  include_examples 'metadata'
  include_examples 'index'
end
