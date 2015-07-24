class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file, year)
    year = Year.find_by(year: year) if file
    if year.present?
      error_message = 'Participants list for this year already exists.'
      new(status: 400, error_message: error_message)
    else
      File.open(Rails.root.join('public', 'uploads',
        file.original_filename), 'wb') do |content|
          content.write(file.read)
        end
      new(status: 200)
    end
  end

  def initialize(options={})
    @status        = options[:status]
    @error_message = options[:error_message]
  end

  def successful?
  end
end
