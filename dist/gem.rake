file pkg("enc-#{version}.gem") => distribution_files("gem") do |t|
  sh "gem build simplecli.gemspec"
  sh "mv enc-#{version}.gem #{t.name}"
end

task "gem:build" => pkg("simplecli-#{version}.gem")

task "gem:clean" do
  clean pkg("simplecli-#{version}.gem")
end

task "gem:release" => "gem:build" do |t|
   puts("simplecli-#{version}.gem")
end
