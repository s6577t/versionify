module Versionify
  def self.bump level = :patch
    version = read_or_create

    case level
    when :major
      version[0] +=1
      version[1] = 0
      version[2] = 0
    when :minor
      version[1] += 1
      version[0] += (version[1].to_f / 10).to_i
      version[1] = (version[1].to_f / 10).to_s.split('.')[1].to_i
      version[2] = 0
    when :patch
      version[2] += 1
    end

    write version
  end            

  def self.get_version
    read_or_create.join '.'
  end

  def self.print_version
    puts "version #{get_version}"
  end  
  
  def self.install_rake_tasks
    
    desc 'print the current source version'
    task :version do
      print_version
    end

    namespace :version do
      namespace :bump do
        task :patch do
          bump :patch
          print_version
        end
        task :minor do
          bump :minor
          print_version
        end
        task :major do
          bump :major
          print_version
        end
      end
    end
  
  end

protected 
  def self.filepath
    '.versionify'
  end
  def self.read_or_create
    fs = File.exists?(filepath) ? File.read(filepath).strip : '0.0.0'
    fs.split('.').map {|s| s.to_i}
  end
  def self.write version
    File.open(filepath,"w+") do |f|
      f.write version.join('.')
    end
  end 
end