require 'spec_helper'

describe GemOfThrones do
  let(:cache){ ActiveSupport::Cache::LibmemcachedStore.new(:namespace => "GemOfThronesTest") }

  before do
    cache.clear
  end

  def new_game(options={})
    GemOfThrones.new({:cache => cache, :mutex_timeout => 0.01}.merge(options))
  end

  it "has a VERSION" do
    GemOfThrones::VERSION.should =~ /^[\.\da-z]+$/
  end

  it "raises with unsupported timeouts" do
    expect{
      new_game(:timeout => 0.1)
    }.to raise_error
  end

  describe "#rise_to_power" do
    it "executes if there is no king" do
      result = nil
      if new_game.rise_to_power
        result = 1
      end
      result.should == 1
    end

    it "executes if the king is alive" do
      result = nil
      if new_game.rise_to_power
        result = 1
      end
      if new_game.rise_to_power
        result = 2
      end
      result.should == 1
    end

    it "executes if the king stays alive" do
      result = nil
      game = new_game
      if game.rise_to_power
        result = 1
      end
      if game.rise_to_power
        result = 2
      end
      result.should == 2
    end

    it "executes if the king died" do
      result = nil
      if new_game(:timeout => 1).rise_to_power
        result = 1
      end
      sleep 1.1
      if new_game.rise_to_power
        result = 2
      end
      result.should == 2
    end

    # using fractions of seconds leads to randomly failing tests
    it "ruling keeps the king in power" do
      result = nil
      old_king = new_game(:timeout => 3)
      if old_king.rise_to_power
        result = 1
      end
      sleep 2
      if old_king.rise_to_power
        result = 2
      end
      sleep 2
      if new_game.rise_to_power
        result = 3
      end
      result.should == 2
    end
  end
end
