class PagesController < ApplicationController
  def erb
    @leika_is_cute = false
    render(:leika)
  end
end
