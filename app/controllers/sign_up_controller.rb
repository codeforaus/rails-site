class SignUpController < ApplicationController
  def index
    @person ||= Person.new
  end

  def success
    @person = Person.find(params[:sign_up_id])
  end

  def create
    @person = Person.new(person_params)
    if @person.save
    begin
      @mc.lists.subscribe('26dc75437b', {'email' => @person.email})
    rescue
      redirect_to sign_up_success_path(@person)
    end
      redirect_to sign_up_success_path(@person)
    else
      render :index
    end
  end

  protected
  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone, :postcode, volunteer_role_ids: [])
  end
end
