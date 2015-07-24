require 'rails_helper'
require 'data_importer'

describe DataImporter do
  describe '.import' do
    it 'responds to import' do
      expect(DataImporter).to respond_to(:import)
      importer = DataImporter.import('some_file.csv', 2015)
    end
  end
end
