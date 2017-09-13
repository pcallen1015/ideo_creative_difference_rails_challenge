require 'rails_helper'

describe CreativeQuality do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:color) }
    it { is_expected.to validate_uniqueness_of(:color) }
  end
end
