# coding: utf-8
RSpec::Support.require_rspec_core "formatters/base_text_formatter"
module RSpec
  module Core
    module Formatters

      class Dots < BaseTextFormatter

        Formatters.register self, :example_passed, :example_pending, :example_started,
              :example_failed, :start, :dump_failures
        attr_accessor :passes,
          :fails,
          :runs,
          :pendings,
          :screen_width,
          :start_time,
          :example_start,
          :debug,
          :show_time,
          :show_description


        def initialize(output)
          @passes = 0
          @fails = 0
          @runs = 0
          @pendings = 0
          @screen_width = `tput cols`.to_i - 1
          @debug = false
          @show_time = @screen_width > 50
          @show_description = @screen_width > 80
          super(output)
        end

        def start(notification)
          @start_time = Time.now
          @example_count = notification.count
          output.puts #new line
        end

        def example_started(example)
          @example_start = Time.now
          print_progress(example)
        end

        def example_pending(example)
          @runs += 1
          @pendings += 1
          print_progress(example, true)
        end

        def example_passed(example)
          @runs += 1
          @passes += 1
          print_progress(example, true)
        end

        def example_failed(example)
          @fails += 1
          @runs += 1
          failure = ConsoleCodes.wrap("\r Failed example: ", :failure) +
                    ConsoleCodes.wrap(example.example.full_description, :white)
          output.puts failure[0..@screen_width].ljust(@screen_width) unless @debug
          print_progress(example, true)
        end


        def dump_summary(summary)
          output.puts
          output.puts
          colour = (@fails == 0)? :success : :failure
          max = [50, @screen_width - 1].min

          output.puts ConsoleCodes.wrap("┌" + "-".ljust(max,"-")  + "┐", colour)
          output.puts ConsoleCodes.wrap("│   #{summary.example_count} test#{summary.example_count == 1? '' : 's'}".ljust(max) + " |", colour)
          output.puts ConsoleCodes.wrap("|   #{@fails} failure#{@fails == 1? '' : 's'}".ljust(max) + " |", colour)
          output.puts ConsoleCodes.wrap("|   Ran in #{Helpers.format_duration summary.duration}".ljust(max) + " |", colour)
          output.puts ConsoleCodes.wrap("└" + "-".ljust(max,"-")  + "┘", colour)
          output.puts
          output.puts summary.colorized_rerun_commands if @fails > 0
        end

        def dump_failures(notification)
           output.puts
           i = 0
           notification.fully_formatted_failed_examples.split("\n").each do |e|
             if (e =~ /^\s*\d/) == 0
               i = 0
             else
               i += 1
             end
             output.puts e if i < 12
           end if @fails > 0
        end

        def print_progress(example, finish = false)

          tot = ConsoleCodes.wrap("#{@example_count}", :white)
          fls = ConsoleCodes.wrap("#{fails}", :failure)
          suc = ConsoleCodes.wrap("#{@runs - @fails}", :success)
          png = ConsoleCodes.wrap("#{@pendings}", :pending)
          current_dur = Time.now - @start_time
          prev_dur = Time.now - @example_start
          tim = ConsoleCodes.wrap( "(Running #{Helpers.format_duration current_dur})", :cyan)
          dot = ConsoleCodes.wrap(" ● ", @fails == 0 ? :success : :failure)

          if @debug
            run = ConsoleCodes.wrap(" Just ran: #{example.example.description}, which took ", :cyan)
            tim2 = ConsoleCodes.wrap(Helpers.format_duration(prev_dur), :red)
            output.puts " #{dot}#{suc}:#{fls}:#{png}/#{tot}#{dot} #{run}#{tim2}" if finish
          else
            all = "\r #{dot}#{suc}:#{fls}:#{png}"
            all << " / #{tot}#{dot}"
            all << " #{tim}" if @show_time
            extra_pixels = @screen_width - 65
            run = ConsoleCodes.wrap(" Now running: #{example.example.description[0..extra_pixels]}", :cyan) unless finish
            all << " #{run}" if @show_description

            output.print all.ljust(@screen_width + (@show_time? 65 : 25))+"\r"
          end
        end

      end
    end
  end
end
