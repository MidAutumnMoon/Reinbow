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
            @sgr_stack = []

            # Ref: https://bixense.com/clicolors/
            @enable = if ENV.key?( "NO_COLOR" )
                          false
                      elsif ENV.key?( "CLICOLOR_FORCE" )
                          true
                      else
                          $stdout.tty?
                      end
        end

        def reinbow? = @enable

        def reinbow!( status = true )
            @enable = status
            self
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

            case data
            in Effect
                data => { code: }
                @sgr_stack.push( "\e[#{code}m" )
            in Ansi
                data => { raw_code: }
                code =  raw_code + ( layer == :fg ? 30 : 40 )
                @sgr_stack.push( "\e[#{code}m" )
            in Rgb
                data => { red:, green:, blue: }
                ground = layer == :fg ? 38 : 48
                @sgr_stack.push( "\e[#{ground};2;#{red};#{green};#{blue}m" )
            else
                raise NotImplementedError, "Can't paint #{data.class}"
            end

            self
        end


        #
        # String behaviours
        #

        def to_s
            if @enable
                sgr = @sgr_stack.join( nil )
                "#{sgr}#{@raw}\e[0m"
            else
                @raw
            end
        end

        def +( other ) = to_s + other.to_s

    end

end
