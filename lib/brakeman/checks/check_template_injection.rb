require 'brakeman/checks/base_check'

class Brakeman::CheckTemplateInjection < Brakeman::BaseCheck
  Brakeman::Checks.add self

  @description = "Searches for evaluation of user input through template injection"

  #Process calls
  def run_check
    Brakeman.debug "Finding ERB.new calls"
    erb_calls = tracker.find_call :target => :ERB, :method => :new, :chained => true

    Brakeman.debug "Processing ERB.new calls"
    erb_calls.each do |call|
      process_result call
    end
  end

  #Warns if eval includes user input
  def process_result result
    return unless original? result

    if input = include_user_input?(result[:call].arglist)
      warn :result => result,
        :warning_type => "Template Injection",
        :warning_code => :template_injection,
        :message => "User input in ruby template",
        :user_input => input,
        :confidence => :high
    end
  end
end
