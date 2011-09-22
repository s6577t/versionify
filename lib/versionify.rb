require 'rake'


Dir["#{File.dirname __FILE__}/versionify/*.rb"].each {|file| require "#{file}" } 

module Versionify
  extend Rake::DSL

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

  def self.version
    read_or_create.join '.'
  end

  def self.print_version
    puts "version #{version}"
  end  

  def self.install_rake_tasks
    require 'rake/dsl_definition'
    desc 'print the current source version'
    task :version do
      print_version
    end

    namespace :version do
      namespace :bump do

        desc 'bump the patch'
        task :patch do
          bump :patch
          print_version
        end

        desc 'bump the minor'
        task :minor do
          bump :minor
          print_version
        end

        desc 'bump the major'
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
