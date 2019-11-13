# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
```ruby
ruby >= 2.6.3
```
* Bundle install
```
bundle install
```
* Create database & Migrate
```ruby
rake db:create db:migrate db:seed
```

* export env variables
```env
export DEVISE_SECRET_KEY=generate_secret_key
```
* For ` sign in ` request

```http
http://localhost:3000/users/sign_in
```
> required params ` email ` and ` password ` 
```json
{
  "user":{
	  "email": "admin@example.com",
	  "password": "password"
  }
}
```
* after successfull signin request, copy the token from Authorization header and send along with all the requests

> as  ` Bearer your_token`

* For list of users
```http
GET http://localhost:3000/api/v1/users
```

* To Create user
```http
POST http://localhost:3000/api/v1/users
```

* Sample user Object for creation

```json
{
	"user": {
		"email": "sample@example.com",
		"name": "sample name",
		"mobile_number": "888888822",
		"password": "password",
		"password_confirmation": "password",
		"tags": [1]
	}
}
```
* For update user
```http
PUT http://localhost:3000/api/v1/users/:id
```
* To disable the user add disabled to user object
```json
disabled: true
```
* For list of tags
```http
GET http://localhost:3000/api/v1/tags
```
* To create new tag
```http
POST http://localhost:3000/api/v1/tags
```
* sample Tag Object for creation

```json
{
	"tag": {"name": "employee"}
}
```

* To update tag
```http
PUT http://localhost:3000/api/v1/tags/:id
```

* To search users
> search with email or name
```
GET http://localhost:3000/api/v1/users?search=query
```
* To sort users
```
GET http://localhost:3000/api/v1/users?sorty_by=field_name&sort_order=asc
```
* To search tags
> search with name
```
GET http://localhost:3000/api/v1/tags?search=query
```
* To sort tags
```
GET http://localhost:3000/api/v1/tags?sort_order=asc
```