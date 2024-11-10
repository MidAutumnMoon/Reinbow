# frozen_string_literal: true

require_relative "./color/effects.rb"
require_relative "./color/rgb.rb"
require_relative "./color/x11.rb"
require_relative "./color/ansi.rb"

module Reinbow

    class Painter

        attr_reader :raw

        # Accepts all parameters that String.new accepts.
        def initialize( input )
            @raw = input.to_s

            # Ref: https://bixense.com/clicolors/
            @enable = if ENV.key?( "NO_COLOR" )
                          false
                      elsif ENV.key?( "CLICOLOR_FORCE" )
                          true
                      else
                          $stdout.tty?
                      end
        end

        #
        # Define method for various color names
        #

        EFFECTS.each_pair do |name, effect|
            define_method( name ) do
                paint!( layer: :effect, data: effect )
            end
        end

        ANSI_COLORS.each_pair do |name, color|
            # e.g. "str".blue
            define_method( name ) { fg color }

            # e.g. "str".on_blue
            define_method( "on_#{name}" ) { bg color }
        end

        def rgb( input )
            fg ( input in Rgb ) ? input : Rgb.hex( input.to_s )
        end

        def on_rgb( input )
            bg ( input in Rgb ) ? input : Rgb.hex( input.to_s )
        end


        #
        # The actual painting methods
        #

        def fg( color ) = paint!( layer: :fg, data: color )

        def bg( color ) = paint!( layer: :bg, data: color )

        def paint!( data:, layer: :fg )
            raise ArgumentError, "Type #{data.class} can not be used for painting" \
                unless data in Effect | Rgb | Ansi

            raise ArgumentError, "layer should be one of :fg, :bg or :effect" \
                unless layer in :fg | :bg | :effect

            sgr_code = nil

            case data
            in Effect
                data => { code: }
                sgr_code = "\e[#{code}m"
            in Ansi
                data => { raw_code: }
                code =  raw_code + ( layer == :fg ? 30 : 40 )
                sgr_code = "\e[#{code}m"
            in Rgb
                data => { red:, green:, blue: }
                ground = layer == :fg ? 38 : 48
                sgr_code = "\e[#{ground};2;#{red};#{green};#{blue}m"
            else
                raise NotImplementedError, "Can't paint #{data.class}"
            end

            "#{sgr_code}#{@raw}" \
                + ( @raw.end_with?( "\e[0m" ) ? "" : "\e[0m" )
        end

    end

end
