require 'rails_helper'

describe SecretSantaCreator do
  describe '.create' do
    it { should be_an_instance_of(SecretSantaCreator) }

    let(:year) { Fabricate(:year, year: 2015) }

    context 'when no constraints' do
      before { 5.times { Fabricate(:participant, year: year) } }
      it 'should create a secret santa for each person' do
        SecretSantaCreator.create(year)
        expect(SecretSanta.count).to eq(5)
      end
      it 'should associate a year to each secret santa entry' do
        SecretSantaCreator.create(year)
        expect(SecretSanta.first.year).to eq(year)
      end
      it 'should have different secret santas for each entry' do
        SecretSantaCreator.create(year)
        uniq_id = SecretSanta.pluck(:giver_id).uniq
        expect(uniq_id.count).to eq(5)
      end
    end
    context 'with constraints' do
      it 'should not be themselves' do
        2.times { Fabricate(:participant, year: year) }
        SecretSantaCreator.create(year)
        first = SecretSanta.first
        last = SecretSanta.last
        expect(first.participant_id).not_to eq(first.giver_id)
        expect(last.participant_id).not_to eq(last.giver_id)
      end
      it 'should not be their partners'
      it 'should not not have duplicate secret santas'
      it 'should not be the same as last year'
    end

    context 'when no Secret Santa last year'

  end

end
