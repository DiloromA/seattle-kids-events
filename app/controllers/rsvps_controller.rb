class RsvpsController < ApplicationController
    before_action :logged_in
    before_action :authenticate_user!
    
    def index 
        @rsvps = Rsvp.all
        @event = Event.find(params[:event_id])
    end

    def show
        #binding.pry
        @event = Event.find_by_id(params[:event_id])
        @rsvp = @event.rsvps.find(params[:id]) #this seems to be probelm
        
    end

    def new
    #binding.pry
      @event = Event.find_by_id(params[:event_id])
      @rsvp = Rsvp.create(rsvp_params)
   
    end
  
    def create
        #binding.pry
        @event = Event.find_by_id(params[:event_id])
        #@rsvp = @event.rsvps.new(rsvp_params.merge(user_id: @user.id, event_id: @event.id))  
        #@rsvp = @event.rsvps.create(rsvp_params) 
        @rsvp = @event.rsvps.create(rsvp_params)
        @rsvp.user = current_user
      
        if @rsvp.save
            #redirect_to event_rsvp_path(@rsvp) #I need to go to rsvp show page
            #redirect_to :controller => 'rsvps', :action => 'show'
            redirect_to @rsvp
            #render :action => :show
        else
            redirect_to @event
        end
      end

      def edit
        @event = Event.find_by_id(params[:event_id])
        @rsvp = @event.rsvps.find(params[:id])
      end
    
      def update
        # research rails update attributes methods
        @event = Event.find_by_id(params[:event_id])
        @rsvp = @event.rsvps.find(params[:id])
        if @rsvp.update_attributes rsvp_params
            redirect_to @rsvp
        else
            redirect_to @event
        end
      end
  
    # def destroy
    #   @rsvp = Rsvp.find_by_id(params[:id])
    #   @rsvp.destroy
    #   redirect_to @event
    # end

    private
    def rsvp_params
        #binding.pry
        params.permit(:attending)
    end
end