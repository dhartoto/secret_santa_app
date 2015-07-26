class FileDeletor
  FILE_PATH = "#{Rails.root}/public/uploads/"

  def self.delete(file)
    file_name = file.original_filename
    if File.exist?(path_to_file(file_name))
      File.delete(path_to_file(file_name))
    end
  end

  private

  def self.path_to_file(file_name)
    "#{FILE_PATH}#{file_name}"
  end
end
