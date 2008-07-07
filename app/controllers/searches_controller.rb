class SearchesController < ApplicationController
  helper :sort
  include SortHelper
  
  def new
    render :action => 'show'
  end
  
  def show
    sort_init 'name'
    sort_update
    
    options = {
      :page => params[:page], 
      :order => "tracks.#{sort_clause}",
      :include => []
    }
    conditions = []
    conditions << 'tracks.status = 1' unless admin?
    unless params[:name].blank?
      conditions << "tracks.name like #{Track.connection.quote('%'+params[:name]+'%')}"
    end
    unless params[:country_code].blank?
      conditions << "tracks.country_code = #{Track.connection.quote(params[:country_code])}"
    end
    unless params[:state].blank?
      conditions << "tracks.state = #{Track.connection.quote(params[:state])}"
    end
    unless params[:category].blank?
      options[:include] << :categories
      conditions << "categories.id = #{Track.connection.quote(params[:category])}"
    end
    options[:conditions] = conditions.join(" AND ")
    
    @results = Track.paginate options
    redirect_to track_url(@results.first) if @results.size == 1
  end
end