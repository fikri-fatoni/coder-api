class BaseController < ApplicationController
  before_action :initial_params

  protected

  def total_count_header(total)
    response.headers['X-Total-Count'] = total
  end

  def initial_params
    @start = params[:_start].to_i if params[:_start].present?
    @end = params[:_end].to_i - 1 if params[:_end].present?
    @sort = params[:_sort] if params[:_sort].present?
    @order = params[:_order] if params[:_order].present?
  end
end
