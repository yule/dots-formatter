# coding: utf-8

if Gem::Version.new(RSpec::Core::Version::STRING).release >= Gem::Version.new('3.0.0')
  require_relative './dots_formatter/dots_formatter_rspec_3'
  DotsFormatter = RSpec::Core::Formatters::Dots
else
  require_relative './dots_formatter/dots_formatter_rspec_2'
  DotsFormatter = Rspec2
end

