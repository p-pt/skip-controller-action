class HelloController < ApplicationController
  def index
  end

  def test
    render json: { message: "tested OK" }
  end

  def test_redirect
    render json: { message: "redirect success!" }
  end
end
