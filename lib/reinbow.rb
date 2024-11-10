# frozen_string_literal: true

require_relative "./reinbow/painter.rb"

module Reinbow

    VERSION = "2.0.0"

    refine String do
        Painter.instance_methods( false ).each do |name|
            define_method( name ) do |*args|
                Painter.new( self ).send( name, *args )
            end
        end
    end

end
