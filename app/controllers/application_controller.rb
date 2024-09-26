class ApplicationController < ActionController::Base
    attr_reader :categories

    def initialize
        super

        @categories = Category.all
    end
end
