module JustimmoClient
  extend JustimmoClient::Utils
  extend JustimmoClient::API

  module_function

  # @!group Realty

  # Get a list of realty objects with limited information.
  # @see V1::RealtyInterface.list query parameters (API Version 1)
  # @option (see V1::RealtyInterface.list)
  # @example Filter by zip code and limit to three results.
  #    JustimmoClient.realties(zip_code: 6800, limit: 3)
  # @return (see V1::RealtyInterface.list)
  def realties(**options)
    interface(:realty).list(options)
  end

  # Get detailed information about a single realty.
  # @see V1::RealtyInterface.detail query parameters (API Version 1)
  # @param (see V1::RealtyInterface.detail)
  # @return (see V1::RealtyInterface.detail)
  def realty(id, lang: nil)
    interface(:realty).detail(id, lang: lang)
  end

  # Get a list of all realty ids.
  # @see V1::RealtyInterface.ids query parameters (API Version 1)
  # @option (see V1::RealtyInterface.ids)
  # @return (see V1::RealtyInterface.ids)
  def realty_ids(options = {})
    interface(:realty).ids(options)
  end

  # @!group Employee

  # Retrieve a list of employee data.
  # @return (see V1::EmployeeInterface.list)
  def employees
    interface(:employee).list
  end

  # Retrieve detailed information about a single employee.
  # @param (see V1::EmployeeInterface.detail)
  # @return (see V1::EmployeeInterface.detail)
  def employee(id)
    interface(:employee).detail(id)
  end

  # Get a list of all employee IDs.
  # @return (see V1::EmployeeInterface.ids)
  def employee_ids
    interface(:employee).ids
  end

  # @!group Basic Data

  # Get a list of available categories.
  # @see V1::RealtyInterface.categories query parameters (API Version 1)
  # @return (see V1::RealtyInterface.categories)
  def realty_categories(**options)
    interface(:realty).categories(options)
  end

  # Get a list of available realty types.
  # @see V1::RealtyInterface.types query parameters (API Version 1)
  # @return (see V1::RealtyInterface.types)
  def realty_types(**options)
    interface(:realty).types(options)
  end

  # Get a list of countries.
  # @see V1::RealtyInterface.countries query parameters (API Version 1)
  # @return (see V1::RealtyInterface.countries)
  def countries(**options)
    interface(:realty).countries(options)
  end

  # Get a list of federal states.
  # @see V1::RealtyInterface.federal_states query parameters (API Version 1)
  # @return (see V1::RealtyInterface.federal_states)
  def federal_states(**options)
    interface(:realty).federal_states(options)
  end

  # Get a list of regions.
  # @see V1::RealtyInterface.regions query parameters (API Version 1)
  # @return (see V1::RealtyInterface.regions)
  def regions(**options)
    interface(:realty).regions(options)
  end

  # Get a list of cities and their zip codes.
  # @see V1::RealtyInterface.zip_codes_and_cities query parameters (API Version 1)
  # @return (see V1::RealtyInterface.zip_codes_and_cities)
  def cities(**options)
    interface(:realty).zip_codes_and_cities(options)
  end
end
