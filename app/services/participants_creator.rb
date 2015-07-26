require 'csv'

class ParticipantsCreator
  FILE_PATH = "#{Rails.root}/public/uploads/"

  attr_reader :year

  def initialize(year)
    @year = year
  end

  def create(file_name)
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
  end

  private

  def path_to_file(file_name)
  "#{FILE_PATH}#{file_name}"
  end
end
