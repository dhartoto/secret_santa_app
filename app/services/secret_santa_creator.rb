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
      secret_santa = possible_pool.shuffle.last unless possible_pool.empty?
      secret_santa = santa_swap(name_list.first, index) if possible_pool.empty?
      assign_secret_santa(participant, secret_santa)
      self.name_list -= [secret_santa]
    end
  end

  # Occasionally the last person to be assigned a secret santa is left with a
  # name that would breach the constraint. #santa_shuffle finds an
  # eligable person who can switch secret santa.
  def santa_swap(remainder, index)
    secret_santa = nil
    exclusions_list.each do |list|
      swapper = Participant.find_by(full_name: list[0])
      swapper_secret_santa = swapper.secret_santa.last
      if swapper_can_receive(remainder, list) and subject_can_receive(swapper_secret_santa, index)
        secret_santa = swapper_secret_santa.full_name
        swapper_secret_santa.update(full_name: remainder)
        break
      end
    end
    secret_santa
  end

  private

  def subject_can_receive(swapper_secret_santa, index)
    !exclusions_list[index].include?(swapper_secret_santa.full_name)
  end

  def swapper_can_receive(remainder, list)
    !list.include?(remainder)
  end

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
