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
    unless params[:name].blank?
      conditions << "name like #{Track.connection.quote('%'+params[:name]+'%')}"
    end
    unless params[:country_code].blank?
      conditions << "country_code = #{Track.connection.quote(params[:country_code])}"
    end
    unless params[:state].blank?
      conditions << "state = #{Track.connection.quote(params[:state])}"
    end
    unless params[:category].blank?
      options[:include] << :categories
      conditions << "categories.id = #{Track.connection.quote(params[:category])}"
    end
    options[:conditions] = conditions.join(" AND ")
    
    @results = Track.paginate options
  end
end