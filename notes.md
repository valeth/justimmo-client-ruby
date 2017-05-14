# Connecting

URL: https://api.justimmo.at/rest/v1

Encode the username and password.

```ruby
Base64.urlsafe_encode64("username:password")
```

Then set the header of the response.

```ruby
RestClient.get(URL, params: {}, Authorization: "Basic #{encoded_credentials)}"
```

# Responses

| Possible Response Code    | Description                            |
| ------------------------- | ---------------------------------------|
| 401 Authenication Failure | Credentials are not correct or not set |
| 404 Not Found             | Resource URL is incorrect              |
| 400 Bad Request           | Parameter evaluation error             |
| 500 Internal Server Error | Something went wrong                   |

# Endpoints

## Realties
* objekt/list
* objekt/detail
* objekt/ids
* objekt/expose
* objekt/anfrage

## Employees
* team/list
* team/detail
* team/ids

## Projects
* projekt/list
* projekt/detail
* projekt/ids

## Basic Data
* objekt/kategorien
* objekt/objektarten
* objekt/laender
* objekt/bundeslaender
* objekt/regionen
* objekt/plzUndOrte
