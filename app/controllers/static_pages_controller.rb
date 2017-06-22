class StaticPagesController < ApplicationController
  def home
   if signed_in?
     @posts = current_user.feed
   else
   end
 end

  def about
  end
end
