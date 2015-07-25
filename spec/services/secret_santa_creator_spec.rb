require 'rails_helper'

describe SecretSantaCreator do
  describe '.create' do

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
        uniq_id = SecretSanta.pluck(:full_name).uniq
        expect(uniq_id.count).to eq(5)
      end
    end
    context 'with constraints' do
      it 'should not be themselves' do
        2.times { Fabricate(:participant, year: year) }
        SecretSantaCreator.create(year)
        first = SecretSanta.first
        last = SecretSanta.last
        expect(first.participant.full_name).not_to eq(first.full_name)
        expect(last.participant.full_name).not_to eq(last.full_name)
      end
      it 'should not be their partners' do
        homer = Fabricate(:participant, year: year, full_name: 'Homer Simpson',
          partner_full_name: 'Marge Simpson')
        marge = Fabricate(:participant, year: year, full_name: 'Marge Simpson',
          partner_full_name: 'Homer Simpson')
        fred = Fabricate(:participant, year: year, full_name: 'Fred Flintstone',
          partner_full_name: 'Wilma Flintstone')
        wilma = Fabricate(:participant, year: year, full_name: 'Wilma Flintstone',
          partner_full_name: 'Fred Flintstone')
        SecretSantaCreator.create(year)
        expect(homer.current_secret_santa).not_to eq('Marge Simpson')
        expect(marge.current_secret_santa).not_to eq('Homer Simpson')
        expect(fred.current_secret_santa).not_to eq('Wilma Flintstone')
        expect(wilma.current_secret_santa).not_to eq('Fred Flintstone')
      end

      it 'should not be the same as last year' do
        previous_year = Fabricate(:year, year: 2014)
        homer = Fabricate(:participant, year: year, full_name: 'Homer Simpson',
          partner_full_name: 'Marge Simpson')
        marge = Fabricate(:participant, year: year, full_name: 'Marge Simpson',
          partner_full_name: 'Homer Simpson')
        fred = Fabricate(:participant, year: year, full_name: 'Fred Flintstone',
          partner_full_name: 'Wilma Flintstone')
        wilma = Fabricate(:participant, year: year, full_name: 'Wilma Flintstone',
          partner_full_name: 'Fred Flintstone')
        nicolai = Fabricate(:participant, year: year, full_name: 'Nicolai Tesla',
          partner_full_name: nil)

        Fabricate(:secret_santa, participant: homer, full_name: 'Wilma Flintstone',
          year: previous_year )
        Fabricate(:secret_santa, participant: marge, full_name: 'Fred Flintstone',
          year: previous_year )
        Fabricate(:secret_santa, participant: fred, full_name: 'Nicolai Tesla',
          year: previous_year )
        Fabricate(:secret_santa, participant: wilma, full_name: 'Homer Simpson',
          year: previous_year )
        Fabricate(:secret_santa, participant: nicolai, full_name: 'Marge Simpson',
          year: previous_year )

        SecretSantaCreator.create(year)
        expect(homer.current_secret_santa).not_to eq('Wilma Flintstone')
        expect(marge.current_secret_santa).not_to eq('Fred Flintstone')
        expect(fred.current_secret_santa).not_to eq('Nicolai Tesla')
        expect(wilma.current_secret_santa).not_to eq('Homer Simpson')
        expect(nicolai.current_secret_santa).not_to eq('Marge Simpson')
      end
    end
  end

end
