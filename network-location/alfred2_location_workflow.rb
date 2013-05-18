#!/usr/bin/env ruby
($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

#Required dependencies 
require "bundle/bundler/setup"
require "alfred"

module Alfred
  class Feedback::Item
    def match?(query)
      all_title_match?(query)
    end
  end
end

if __FILE__ == $PROGRAM_NAME

  Alfred.with_friendly_error do |alfred|
    alfred.with_rescue_feedback = true

    result = `networksetup -listlocations`.split(/\n/)
    result.sort!

    unless ARGV.empty?
      result.reject!{|location| !location.downcase.start_with?(ARGV[0].downcase) }
    end

    feedback = alfred.feedback

    result.each  do |nl|
      feedback.add_item({
        :uid => "#{nl}",
        :title => "#{nl}",
        :arg => "#{nl}",
        :icon => {:type => "default", :name => "nticon.png"},
        :subtitle => "Location network -> #{nl}"
      })
    end
    puts feedback.to_alfred()
  end
end

