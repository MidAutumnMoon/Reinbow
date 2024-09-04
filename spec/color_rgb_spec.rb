# frozen_string_literal: true

require "spec_helper"

require "reinbow/color/rgb"
require "reinbow/color/x11"

Rgb = Reinbow::Rgb

describe Rgb do

    it "validates all RGB values are in range" do
        expect { Rgb.new( red: 256, green: 253, blue: -11 ) }
            .to raise_error( ArgumentError )
    end

    it "has the shortcut initialization working" do
        expect( Rgb[1, 2, 3] ).to \
            eq Rgb.new( red: 1, green: 2, blue: 3 )
    end

    context "when build RGB from HEX string" do

        let( :the_blue ) { Rgb[102, 204, 255] }

        it "validates input HEX" do
            expect { Rgb.hex( "#znxcpl" ) }.to raise_error( ArgumentError )
            expect { Rgb.hex( "#xcpl" ) }.to raise_error( ArgumentError )
        end

        it "ignores leading #" do
            expect( Rgb.hex( "#66ccff" ) ).to eq the_blue
            expect( Rgb.hex( "66ccff" ) ).to eq the_blue
        end

        it "converts HEX to RGB" do
            expect( Rgb.hex( "#66ccff" ) ).to eq the_blue
        end

        it "converts three letter HEX to RGB" do
            expect( Rgb.hex( "#6cf" ) ).to eq the_blue
        end

    end

end
