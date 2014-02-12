class ErrorController < ApplicationController

  def error_404
    render '404', status => 404 
  end
end
