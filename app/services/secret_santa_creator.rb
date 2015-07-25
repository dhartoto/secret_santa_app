class SecretSantaCreator

  def self.create(year)
    participants = year.participants
    givers = participants.rotate
    participants.each_with_index do |participant, index|
      participant.secret_santa.create(year: year,
        giver_id: givers[index].id)
    end
    new()
  end
end
