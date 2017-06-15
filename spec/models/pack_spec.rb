require 'rails_helper'

RSpec.describe Pack, type: :model do
  context 'pack' do
    subject { build :pack }
    it { is_expected.to be_valid }
  end
end
