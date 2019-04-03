require 'rails_helper'

describe BookSuggestion do
  context 'when a valid book suggestion is built' do
    subject(:book_suggestion) { build(:book_suggestion) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_presence_of(:year) }
  end

  context 'when an invalid book suggestion is built' do
    subject(:book_suggestion) { build(:book_suggestion, title: nil) }

    it { is_expected.to_not be_valid }
  end

  context 'when a valid book suggestion is created' do
    subject(:book_suggestion) { create(:book_suggestion) }

    it { is_expected.to be_persisted }
  end

  context 'when an invalid book suggestion is created' do
    let(:book_suggestion) { build(:book_suggestion, title: nil) }

    it 'raises an invalid record error' do
      expect { book_suggestion.save! }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
