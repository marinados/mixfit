class ApiBaseController < ApplicationController

	class UnknownUserError < StandardError; end

	rescue_from UnknownUserError, with: :render_unauthorized
	
	def current_user
		@_current_user ||= get_current_user
	end

	def get_current_user
		User.find_by(name: params[:username]) || raise UnknownUserError
	end

	def render_unauthorized
		render(head: :unauthorized)
	end

end