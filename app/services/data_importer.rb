class DataImporter
  attr_accessor :status, :error_message

  def self.import(file, year)
    uploader = FileUploader.upload(file, 2015)
    if uploader.successful?
      year = Year.create(year: year)
      ParticipantsCreator.create(year)
      SecretSantaCreator.create(year)
      new(status: 200)
    else
      new(status: 400, error_message: uploader.error_message)
    end
  end

  def initialize(options={})
    @status        = options[:status]
    @error_message = options[:error_message]
  end

  def successful?
    status == 200
  end
end
