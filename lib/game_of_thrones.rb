require "game_of_thrones/version"

class GameOfThrones
  def initialize(options)
    @options = {
      :timeout => 10 * 60,
      :cache_key => "GameOfThrones.",
      :cache => "You have to set :cache",
      :mutex_timeout => 0.1
    }.merge(options)
  end

  def rise_to_power
    yield if try_to_get_power
  end

  private

  def try_to_get_power
    if no_king? or in_power?
      take_power
      sleep mutex_timeout # multiple people could try to take power simultaneously
      in_power?
    else
      false
    end
  end

  def no_king?
    not current_king
  end

  def in_power?
    current_king == myself
  end

  def mutex_timeout
    @options[:mutex_timeout] + (@options[:mutex_timeout] * rand)
  end

  def take_power
    @options[:cache].write(@options[:cache_key], myself, :expires_in => @options[:timeout])
  end

  def current_king
    @options[:cache].read(@options[:cache_key])
  end

  def myself
    @myself ||= "#{Process.pid}-#{object_id}-#{Time.now.to_f}"
  end
end
