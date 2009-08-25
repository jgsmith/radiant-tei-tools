namespace :radiant do
  namespace :extensions do
    namespace :tei_tools do
      
      desc "Runs the migration of the Tei Tools extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          TeiToolsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          TeiToolsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Tei Tools to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from TeiToolsExtension"
        Dir[TeiToolsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TeiToolsExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
