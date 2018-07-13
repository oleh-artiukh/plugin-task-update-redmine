class TaskUpdatePluginController < ApplicationController
  def index
  	@pre_domain = DomainStore.first
  	if @pre_domain.nil?
  		@not_domain = 'Url не назначен'
  	end
  end

  def save_domain
  	if not domain_params.nil?
  		@domain = DomainStore.first

  		if @domain.nil?
  			@domain = DomainStore.new(domain_params)
  			@domain.save
  		else
  			@domain.update(domain_params)
  		end
		end

		render json: @domain
  end

  private
 		 def domain_params
 		 	params.permit(:domain)
  	 end
end
