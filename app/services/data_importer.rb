class DataImporter
  attr_accessor :status, :error_message

  def self.import(file_name, year)
    uploader = FileUploader.upload(file_name)
    new()
  end

  def successful?
  end
end
