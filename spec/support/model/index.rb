RSpec.shared_examples 'index' do
  it 'is not valid without an index' do
    subject.index = nil
    expect(subject).to_not be_valid
  end
end
