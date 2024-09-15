# frozen_string_literal: true

module Reinbow

    # The range of "code" is deliberately not checked
    # so that the user can use non common codes.
    Effect = Data.define( :code )

    # Explaination from Wikipedia
    # https://en.wikipedia.org/wiki/ANSI_escape_code#SGR
    EFFECTS = {
        # Reset or normal
        reset: 0,

        # Bold or increased intensity
        bold: 1,

        # Faint, decreased intensity, or dim
        dim: 2,

        # Italic
        italic: 3,

        # Underline
        underline: 4,

        # Slow blink and Rapid blink
        # (may have no effect due to accessibility reasons)
        blink: 5,
        # rapid_blink: 6,

        # Reverse video or invert
        invert: 7,

        # Conceal or hide
        hide: 8,

        # Crossed-out, or strike
        strike: 9,

        # Doubly underlined
        double_underline: 21,

        # Overlined
        overline: 53,
    }.transform_values { Effect.new( _1 ) }.freeze

end
