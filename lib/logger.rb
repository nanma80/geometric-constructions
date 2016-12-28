class Logger
  def self.log(content)
    if verbose
      puts "[#{Time.now.utc}] #{content}"
    end
  end

  def self.verbose
    ENV['_'].nil? || !ENV['_'].include?('rspec')
  end
end