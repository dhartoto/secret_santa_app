class SecretSantaCreator

  def self.create(year)
    participants = year.participants
    participants.each_with_index do |participant, index|
      participant.secret_santa.create(year: year,
        giver_id: participants[index].id)
    end
    new()
  end
end
