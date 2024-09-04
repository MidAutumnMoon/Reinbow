# frozen_string_literal: true

module Reinbow

    Ansi = Data.define( :raw_code ) do
        def initialize( raw_code: )
            raise ArgumentError, "ANSI color code should be in range 0..9" \
                unless raw_code in 0..9

            super
        end
    end

    ANSI_COLORS = {
        black: 0,
        red: 1,
        green: 2,
        yellow: 3,
        blue: 4,
        magenta: 5,
        cyan: 6,
        white: 7,
        # spcial code to reset colors to their defaults
        default: 9,
    }.transform_values { Ansi.new( _1 ) }.freeze

end
