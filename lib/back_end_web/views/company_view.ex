defmodule BackEndWeb.CompanyView do
  use BackEndWeb, :view

  def render("index.json", %{companys: companys}) do
    %{success: true, data: render_many(companys, BackEndWeb.CompanyView, "company.json")}
  end

  def render("show.json", %{company: company}) do
    %{success: true, data: render_one(company, BackEndWeb.CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{
      id: company.id,
      company_name: company.company_name,
      personnel_scale: company.personnel_scale,
      company_address: company.company_address,
      province: company.province,
      description: company.description,
      field_of_activity: company.field_of_activity,
      website: company.website,
      company_phone_number: company.company_phone_number,
      fax: company.fax
    }
  end
  end