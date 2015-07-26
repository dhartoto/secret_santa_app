class SecretSantaCreator

  attr_reader :year, :participants
  attr_accessor :exclusions_list, :name_list

  def initialize(year)
    @year = year
    @participants = year.participants
  end

  def create
    run_secret_santa_algorithm
  end

  def run_secret_santa_algorithm
    self.name_list = participants.pluck(:full_name)
    self.exclusions_list = build_exclusions_for_each_participant

    participants.each_with_index do |participant, index|
      possible_pool = name_list - exclusions_list[index]
      secret_santa = possible_pool.shuffle.last
      assign_secret_santa(participant, secret_santa)
      self.name_list -= [secret_santa]
    end
  end

  private

  def build_exclusions_for_each_participant
    participants.map do |p|
      [p.full_name, p.partner_full_name, p.current_secret_santa]
    end
  end

  def assign_secret_santa(participant, secret_santa)
    participant.secret_santa.create(year: year,
      full_name: secret_santa)
  end
end
