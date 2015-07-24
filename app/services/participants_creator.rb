require 'csv'

class ParticipantsCreator
  FILE_PATH = "#{Rails.root}/public/uploads/"

  def self.create(file_name, year)
    file = CSV.read(path_to_file(file_name), headers: true)
    file.each do |participant|
      Participant.create(
        full_name: participant['full_name'],
        partner_full_name: participant['partner_full_name'],
        year: year
      )
    end
    new()
  end

  private

  def self.path_to_file(file_name)
  "#{FILE_PATH}#{file_name}"
  end
end
