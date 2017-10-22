SimpleCov.start do
  add_filter "/bin/"
  add_filter "/cache/"
  add_filter "/examples/"
  add_filter "/spec/"
  add_group "V1/Models",       "lib/justimmo_client/api/v1/models"
  add_group "V1/Representers", "lib/justimmo_client/api/v1/representers"
  add_group "V1/Requests",     "lib/justimmo_client/api/v1/requests"
  add_group "V1/Interfaces",   "lib/justimmo_client/api/v1/interfaces"
end
