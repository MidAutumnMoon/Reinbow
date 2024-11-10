# frozen_string_literal: true

require "spec_helper.rb"
require "reinbow/painter"

Painter = Reinbow::Painter

using Reinbow

# Expected results should be verified visually.
describe Painter do

    subject { Painter.new( "lomn" ) }

    it "is its own class" do
        expect( subject ).to be_a Painter
    end

    context "#paint!" do
        x11 = Reinbow::X11_COLORS

        it "validates input data" do
            expect { subject.paint!( data: "not accepted" ) }
                .to raise_error( ArgumentError )

            expect { subject.paint!( data: x11[:yellow], layer: :anywhere ) }
                .to raise_error( ArgumentError )
        end
    end

    context "shorthand methods for #paint!" do
        ansi = Reinbow::ANSI_COLORS

        it "#fg for foreground" do
            expect( subject.fg( ansi[:blue] ) )
                .to eq( "\e[34mlomn\e[0m" )
        end

        it "#bg for background" do
            expect( subject.bg( ansi[:blue] ).to_s )
                .to eq( "\e[44mlomn\e[0m" )
        end
    end

    it "has methods to paint terminal effects" do
        expect( subject.italic.bold.to_s )
            .to eq( "\e[1m\e[3mlomn\e[0m" )
    end

    it "has methods to paint ANSI terminal colors" do
        expect( subject.red.on_blue.to_s )
            .to eq( "\e[44m\e[31mlomn\e[0m" )
    end

    context "paint RGB colors on terminal" do
        x11 = Reinbow::X11_COLORS

        it "can use predefined colors" do
            expect( subject.rgb( x11[:crimson] ).to_s )
                .to eq( "\e[38;2;220;20;60mlomn\e[0m" )
        end

        it "can use HEX as colors" do
            expect( subject.rgb( "#66ccff" ).to_s )
                .to eq( "\e[38;2;102;204;255mlomn\e[0m" )
        end

        it "can use RGB as background color" do
            expect( subject.on_rgb( x11[:crimson] ).to_s )
                .to eq( "\e[48;2;220;20;60mlomn\e[0m" )
        end
    end

    it "can mix everything together" do
        x11 = Reinbow::X11_COLORS
        mess = subject.rgb( x11[:crimson] ).on_blue.italic.strike
        expect( mess.to_s )
            .to eq( "\e[9m\e[3m\e[44m\e[38;2;220;20;60mlomn\e[0m" )
    end

    it "still provides access to the raw string" do
        expect( subject.raw ).to eq( "lomn" )
    end

end
