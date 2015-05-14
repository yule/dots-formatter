# coding: utf-8
require 'rspec/core/formatters/progress_formatter'
class Rspec2 < RSpec::Core::Formatters::BaseTextFormatter

  def start(number)
    super(number)
    output.puts
  end

  def example_started(example)
    super(example)
    print_progress(example)
  end

  def example_passed(example)
    super(example)
    #print_progress
  end
  
  def example_failed(example)
    super(example)
    @failure_count += 1
    print_progress(example)
  end


  def dump_summary(duration, example_count, failure_count, pending_count)
    output.puts
    output.puts
    output.puts "Finished in #{format_duration duration}"
    output.puts
    if failure_count == 0
      output.puts success_color("┌" +  "--------------" + "-".ljust(20,"-") + "┐")
      output.puts success_color("│" +  "　(＾ヽ--△<＾)" + " ".ljust(20) + "│")
      output.puts success_color("│" +  " /　　　　　~▽" + " ".ljust(20) + "│")
      output.puts success_color("│" +  "士　0　o　0 士" + " #{example_count} test#{example_count > 1? 's' : ' '}".ljust(20) + "│")
      output.puts success_color("│" +  " メ ＿＿＿ メ " + " ".ljust(20) + "│") 
      output.puts success_color("│" +  "　　/ へ`-L、 " + " No failures.".ljust(20) + "│")
      output.puts success_color("│" +  " (~(　し′｜ ）" + " ".ljust(20) + "│")
      output.puts success_color("└" +  "--------------" + "-".ljust(20,"-") + "┘")
    else
      output.puts failure_color("┌" + "-".ljust(50,"-")  + "┐")
      output.puts failure_color("│   #{example_count} test#{example_count > 1? 's' : ' '}, #{failure_count} failure#{failure_count > 1? 's' : ' '}".ljust(50) + " │")
      output.puts failure_color("└" + "-".ljust(50,"-")  + "┘")
      super
    end
  end

  def print_progress(example)
    if @failure_count > 0
      output.print failure_color("\r ● #{@examples.count - @failure_count}/#{@example_count}. #{@pending_count + '. pending.' if @pending_count > 0} #{example.full_description.ljust(150)}")
    elsif @pending_count > 0
      output.print pending_color("\r ● #{@examples.count - @failure_count}/#{@example_count}. #{@pending_count} pending #{example.full_description.ljust(150)}")
    else
      output.print success_color("\r ● #{@examples.count - @failure_count}/#{@example_count} #{example.full_description.ljust(150)}\r")
    end

  end

end
