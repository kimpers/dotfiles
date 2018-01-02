File.open('./ruby_gems.txt').each do | line |
  name = line.split(' ')[0]
  versions = line.split('(')[1].chomp.delete(' )').split(',')

  versions.each do | version |
    clean_version = version.delete('default:')
    puts "Installing #{name} (#{clean_version})"
    puts `gem install #{name} --version=#{clean_version}  --ignore-dependencies`
  end
end
