# frozen_string_literal: true

module Reinbow

    Rgb = Data.define( :red, :green, :blue ) do
        def initialize( red:, green:, blue: )
            raise ArgumentError, "RGB values should be in range 0..255" \
                unless [ red, green, blue ].all? { _1 in 0..255 }

            super
        end

        # Shortcut for initializing RGB without specifing
        # keyword arguments.
        def self.[]( red, green, blue )
            new red:, green:, blue:
        end

        # Convert HEX value to RGB.
        # HEX string is case insensetive and with or without the leading "#".
        # See also https://github.com/devrieda/color_conversion/
        def self.hex( str )
            # remove "#"s
            str = str.gsub( "#", "" ).downcase

            # ensure it's actually a hex
            raise ArgumentError, "Input contains non HEX characters" \
                unless str.match?( /^[a-f0-9]+$/i )

            # ensure the hex is either 6 or 3 letters
            raise ArgumentError, "HEX color has wrong length that is nither 6 nor 3" \
                unless str.size in 3 | 6

            # padding 3 letter hex by repeating each character
            str = str.chars.map { _1 * 2 }.join( nil ) \
                if str.size == 3

            # rubocop:disable Layout/EmptyLinesAroundArguments
            self[
                # "aabbcc"
                #  ^^
                str[0, 2].hex,

                # "aabbcc"
                #    ^^
                str[2, 2].hex,

                # "aabbcc"
                #      ^^
                str[4, 2].hex,
            ]
            # rubocop:enable Layout/EmptyLinesAroundArguments
        end
    end

end
