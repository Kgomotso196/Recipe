class FoodsController < ApplicationController
  def index
    @food = Food.all
  end
end
