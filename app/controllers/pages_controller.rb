class PagesController < ApplicationController
  include S3Helper

  before_action :signed_in_user

  def home
  end

  def about

  end

  def resume

    resume_data = get_resume_data

    send_data resume_data, :filename => 'resume.pdf',
                           :disposition => 'inline'


  end

  def error
  end

end
