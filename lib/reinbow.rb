# frozen_string_literal: true

require_relative "./reinbow/painter.rb"

module Reinbow

    VERSION = "1.2.0"

    refine String do
        Painter.instance_methods( false ).each do |name|
            define_method( name ) do |*args|
                Painter.new( self ).send( name, *args )
            end
        end
    end

end


# rubocop:disable Naming/MethodName

def Reinbow( content, enable_color: true )
    Reinbow::Painter.new( content ).reinbow!( enable_color )
end

# rubocop:enable Naming/MethodName
