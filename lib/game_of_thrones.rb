require "game_of_thrones/version"

class GameOfThrones
  def initialize(options)
    @options = {
      :timeout => 10 * 60,
      :cache_key => "GameOfThrones.",
      :cache => "You have to set :cache",
    }.merge(options)

    raise "Only integers are supported for timeout" if options[:timeout].is_a?(Float)
  end

  def rise_to_power
    i_am_king! :try => !in_power?
  end

  private

  def i_am_king!(options)
    @options[:cache].write(@options[:cache_key], myself,
      :expires_in => @options[:timeout],
      :unless_exist => options[:try]
    )
  end

  def in_power?
    current_king == myself
  end

  def current_king
    @options[:cache].read(@options[:cache_key])
  end

  def myself
    @myself ||= "#{Process.pid}-#{object_id}-#{Time.now.to_f}"
  end
end
