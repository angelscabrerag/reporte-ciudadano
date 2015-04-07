require 'spec_helper'

feature 'As a service admin I can edit a public servant' do

  let(:admin) { create(:admin, :service_admin) }

  background do
    sign_in_admin admin
  end

  scenario 'I can edit a public servant' do
    public_servants = create_list(:admin, 3, :public_servant)
    first_public_servant = public_servants.first

    visit admins_dashboards_path
    click_link "Servidores Públicos"
    click_edit_link_for first_public_servant

    expect(find_field('admin[name]').value).to eq first_public_servant.name

    fill_in "admin[name]", with: "New name"
    select "Dependencia 2", from: "admin[dependency]"
    select "Unidad administrativa 2", from: "admin[administrative_unit]"
    click_button "Actualizar"

    expect(page).to have_content "El servidor público se ha actualizado exitosamente"
    expect(page).to have_content "New name"
    expect(page).to have_content "Dependencia 2"
    expect(page).to have_content "Unidad administrativa 2"
  end

  def click_edit_link_for(public_servant)
    find("a#edit_public_servant_#{public_servant.id}").click
  end
end