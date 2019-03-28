require 'rails_helper'

describe Book do
  context 'when a valid book is built' do
    subject(:book) { build(:valid_book) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to belong_to(:image) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_presence_of(:year) }
  end

  context 'when an invalid book is built' do
    subject(:book) { build(:book) }

    it { is_expected.to_not be_valid }
  end

  context 'when a valid book is created' do
    subject(:book) { create(:valid_book) }

    it { is_expected.to be_persisted }
  end

  context 'when an invalid book is created' do
    let(:book) { build(:book) }

    it 'raises an invalid record error' do
      expect { book.save! }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
