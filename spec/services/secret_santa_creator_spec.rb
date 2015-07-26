require 'rails_helper'

describe SecretSantaCreator do
  describe '.create' do

    let(:year) { Fabricate(:year, year: 2015) }
    let(:creator) { SecretSantaCreator.new(year) }
    
    let!(:homer) { Fabricate(:participant, year: year, full_name: 'Homer Simpson',
      partner_full_name: 'Marge Simpson') }
    let!(:marge) { Fabricate(:participant, year: year, full_name: 'Marge Simpson',
      partner_full_name: 'Homer Simpson') }
    let!(:fred) { Fabricate(:participant, year: year, full_name: 'Fred Flintstone',
      partner_full_name: 'Wilma Flintstone') }
    let!(:wilma) { Fabricate(:participant, year: year, full_name: 'Wilma Flintstone',
      partner_full_name: 'Fred Flintstone') }
    let!(:nicolai) { Fabricate(:participant, year: year, full_name: 'Nicolai Tesla',
        partner_full_name: nil) }

    context 'when no constraints' do

      it 'should create a secret santa for each person' do
        creator.create
        expect(SecretSanta.count).to eq(5)
      end
      it 'should associate a year to each secret santa entry' do
        creator.create
        expect(SecretSanta.first.year).to eq(year)
      end
      it 'should have different secret santas for each entry' do
        creator.create
        uniq_id = SecretSanta.pluck(:full_name).uniq
        expect(uniq_id.count).to eq(5)
      end
    end

    context 'with constraints' do

      it 'should not be themselves' do
        creator.create
        first = SecretSanta.first
        second = SecretSanta.second
        expect(first.participant.full_name).not_to eq(first.full_name)
        expect(second.participant.full_name).not_to eq(second.full_name)
      end

      it 'should not be their partners' do
        creator.create
        expect(homer.current_secret_santa).not_to eq('Marge Simpson')
        expect(marge.current_secret_santa).not_to eq('Homer Simpson')
        expect(fred.current_secret_santa).not_to eq('Wilma Flintstone')
        expect(wilma.current_secret_santa).not_to eq('Fred Flintstone')
      end

      it 'should not be the same as last year' do
        previous_year = Fabricate(:year, year: 2014)
        previous_year_list =  [[homer, 'Wilma Flintstone'],
          [marge, 'Fred Flintstone'], [fred, 'Nicolai Tesla'], [wilma, 'Homer Simpson'],
          [nicolai, 'Marge Simpson']]
        previous_year_list.each do |p|
          Fabricate(:secret_santa, participant: p[0], full_name: p[1],
            year: previous_year )
        end
        creator.create
        expect(homer.current_secret_santa).not_to eq('Wilma Flintstone')
        expect(marge.current_secret_santa).not_to eq('Fred Flintstone')
        expect(fred.current_secret_santa).not_to eq('Nicolai Tesla')
        expect(wilma.current_secret_santa).not_to eq('Homer Simpson')
        expect(nicolai.current_secret_santa).not_to eq('Marge Simpson')
      end
    end
  end

  # To test #santa_swap, change code in SecretSantaCreator from
  # secret_santa = possible_pool.shuffle.last to
  # secret_santa = possible_pool.first
  # This replicates the senario where the last person has no eligable
  # secret santas. In this case because it's himself.
  describe '#santa_swap' do
    let(:year) { Fabricate(:year, year: 2015) }

    let!(:homer) { Fabricate(:participant, year: year, full_name: 'Homer Simpson',
      partner_full_name: 'Marge Simpson') }
    let!(:marge) { Fabricate(:participant, year: year, full_name: 'Marge Simpson',
      partner_full_name: 'Homer Simpson') }
    let!(:fred) { Fabricate(:participant, year: year, full_name: 'Fred Flintstone',
      partner_full_name: 'Wilma Flintstone') }
    let!(:wilma) { Fabricate(:participant, year: year, full_name: 'Wilma Flintstone',
      partner_full_name: 'Fred Flintstone') }
    let!(:nicolai) { Fabricate(:participant, year: year, full_name: 'Nicolai Tesla',
        partner_full_name: nil) }

    it 'finds an eligable person to swap with' do
      creator = SecretSantaCreator.new(year)
      creator.create
      expect(SecretSanta.pluck(:full_name)).not_to include(nil)
    end
  end
end
