# coding: utf-8

if Gem::Version.new(RSpec::Core::Version::STRING).release >= Gem::Version.new('3.0.0')
  require_relative './dots_formatter/dots'
  DotsFormatter = RSpec::Core::Formatters::Dots
end

