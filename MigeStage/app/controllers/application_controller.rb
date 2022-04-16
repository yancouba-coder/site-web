class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  protect_from_forgery prepend: true

end
