require 'rake'
require 'rake/file_utils_ext'

class SnapDeploy::Provider::Update < Clamp::Command

  SnapDeploy::CLI.subcommand           'update',      'Update snap deploy',     self

  include SnapDeploy::CLI::DefaultOptions
  include SnapDeploy::Helpers
  include Rake::FileUtilsExt

  option '--revision',
    'REVISION',
    "Update to specified revision",
    :default => 'release'

  def execute
    cd(File.dirname(__FILE__), :verbose => !!verbose?) do
      $stderr.puts "DEPRECATION WARNING: snap-deploy update will be deprecated soon"
      sh("sudo $(which git) fetch --all",  :verbose => !!verbose?)
      sh("sudo $(which git) merge --ff-only origin/#{revision}", :verbose => !!verbose?)
      sh("cd \"$(git rev-parse --show-toplevel)\" && sudo ./install.sh")
    end
  end

end
