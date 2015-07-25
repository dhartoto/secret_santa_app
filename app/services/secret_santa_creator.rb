class SecretSantaCreator

  def self.create(year)
    participants = year.participants
    participants_constraints = build_constraints(participants, year)
    secret_santas = participants.map{ |participant| participant.full_name }
    participants.each_with_index do |participant, index|
      possible_pool = secret_santas.select{|x| not participants_constraints[index].include?(x) }
      secret_santa = possible_pool.shuffle.last
      participant.secret_santa.create(year: year,
        full_name: secret_santa)
      secret_santas -= [secret_santa]
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
