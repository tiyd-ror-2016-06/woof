class UsersController < ApplicationController
  def new
    @user = UserForm.new
  end

  def create
    @user = UserForm.new
    if @user.save params[:user]
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = UserForm.new id: params[:id]
  end

  def update
    @user = UserForm.new id: params[:id]
    if @user.save params[:user]
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end
end
