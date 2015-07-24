class DataImporter
  attr_accessor :status, :error_message

  def self.import(file_name, year)
    uploader = FileUploader.upload(file_name)
    SecretSantaCreator.create(year)
    Year.create(year: year)
    new(status: 200)
  end

  def initialize(options={})
    @status = options[:status]
  end

  def successful?
  end
end
