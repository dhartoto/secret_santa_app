require 'csv'

module FileReader
  FILE_PATH = "#{Rails.root}/public/uploads/"

  def self.read
    files = Dir.entries("#{Rails.root}/public/uploads/")
    file = files[2]
    CSV.read(path_to_file(file), headers: true)
  end

  private

  def self.path_to_file(file_name)
    "#{FILE_PATH}#{file_name}"
  end
end
