# Posts

Install gems:

```
bundle install
```

Create new database user with superuser role. Assign a password to new role (password: ruby):
```
createuser -dlsP ruby
```

Create database:
```
bundle exec rake db:create
```

Apply migration:
```
bundle exec rake db:migrate
```

```
RACK_ENV=test bundle exec rake db:migrate
```

Run seeds:

```
bundle exec rake db:seed
```

#### Rake tasks

Start server at development mode:
```
bundle exec rake app:server
```

Run pry console

```
bundle exec rake app:console
```

### Tests

```
rspec
```
=)
