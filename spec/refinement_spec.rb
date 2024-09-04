# frozen_string_literal: true

require "spec_helper"
require "reinbow"


module WithRefine
    using Reinbow
    def self.blue_hello = "hello".blue.to_s
end

module WoRefine
    def self.blue_hello = "hello".blue.to_s
end


describe "Refinement" do

    it "is using refinement" do
        expect( WithRefine.blue_hello )
            .to eq( Reinbow( "hello" ).blue.to_s )
    end

    it "does not pullot objects" do
        expect { WoRefine.blue_hello }
            .to raise_error( NoMethodError )
    end

end
