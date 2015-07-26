class ParticipantsCreator
  attr_reader :year

  def initialize(year)
    @year = year
  end

  def create
    file = FileReader.read
    file.each do |line|
      participant = Participant.find_by(full_name: line['full_name'])
      if participant
        participant.update(year: year)
      else
        Participant.create(full_name: line['full_name'],
          partner_full_name: line['partner_full_name'],
          year: year
        )
      end
    end
  end
end
