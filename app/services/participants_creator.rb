require 'csv'

class ParticipantsCreator
  FILE_PATH = "#{Rails.root}/public/uploads/"

  def self.create(file_name, year)
    file = CSV.read(path_to_file(file_name), headers: true)
    file.each do |line|
      participant = Participant.find_by(full_name: line['full_name'])
      if participant
        participant.update(year: year)
      else
        Participant.create(
          full_name: line['full_name'],
          partner_full_name: line['partner_full_name'],
          year: year
        )
      end
    end
    new()
  end

  private

  def self.path_to_file(file_name)
  "#{FILE_PATH}#{file_name}"
  end
end
