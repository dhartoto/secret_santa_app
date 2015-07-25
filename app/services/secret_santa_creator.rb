class SecretSantaCreator

  def self.create(year)
    participants = year.participants
    constraints = build_constraints(participants, year)
    givers = participants.map{ |participant| participant.full_name }
    participants.each_with_index do |participant, index|
      participants_posibble_givers = givers - constraints[index]
      secret_santa = participants_posibble_givers.shuffle.last
      participant.secret_santa.create(year: year,
        full_name: givers.pop)
      givers - [secret_santa]
    end
    new()
  end

  def self.build_constraints(participants, year)
    last_year = Year.find_by(year: year.year - 1 )
    participants.map do |p|
      [p.full_name, p.partner_full_name, p.current_secret_santa]
    end
  end
end
