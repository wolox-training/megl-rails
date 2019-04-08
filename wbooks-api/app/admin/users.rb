ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :name, :first_name, :last_name, :locale

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :first_name
    column :last_name
    column :locale
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :first_name
      f.input :last_name
      f.input :locale
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
