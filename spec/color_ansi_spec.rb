# frozen_string_literal: true

require "spec_helper"

require "reinbow/color/ansi"

Ansi = Reinbow::Ansi

describe Ansi do

    it "validates input" do
        expect { Ansi.new( 100 ) }.to raise_error( ArgumentError )
    end

end
