class SearchesController < ApplicationController
  helper :sort
  include SortHelper
  
  def new
    render :action => 'show'
  end
  
  def show
    sort_init 'name'
    sort_update
    
    conditions = []
    unless params[:name].blank?
      conditions << "name like #{Track.connection.quote('%'+params[:name]+'%')}"
    end
    unless params[:country_code].blank?
      conditions << "country_code = #{Track.connection.quote(params[:country_code])}"
    end
    
    @results = Track.paginate :page => params[:page], :order => sort_clause, :conditions => conditions.join(" AND ")
  end
end