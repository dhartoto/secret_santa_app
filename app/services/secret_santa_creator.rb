class SecretSantaCreator

  def self.create(year)
    participants = year.participants
    constraints = build_constraints(participants)
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

  def self.build_constraints(participants)
    participants.pluck(:full_name, :partner_full_name)
  end
end
