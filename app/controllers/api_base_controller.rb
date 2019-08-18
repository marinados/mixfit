class ApiBaseController < ApplicationController

	class UnknownUserError < StandardError; end

	DEFAULT_PER_PAGE = 20
	
	rescue_from UnknownUserError, with: :render_unauthorized
	
	def current_user
		@_current_user ||= get_current_user
	end

	def get_current_user
		user = User.find_by(name: params[:username]) 
		return user if user
		raise UnknownUserError
	end

	# Since this is the closest to authentication that we have
	# I prefer to render the 401 status instead of bad request,
	# for further consistency.
	def render_unauthorized
		render(status: :unauthorized)
	end

end