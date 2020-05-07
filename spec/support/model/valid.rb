RSpec.shared_examples 'valid' do
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
