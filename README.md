# Errawr

Define and raise localized errors like a baws!

[![Build Status](https://travis-ci.org/anthonator/errawr.png?branch=master)](https://travis-ci.org/anthonator/errawr) [![Dependency Status](https://gemnasium.com/anthonator/errawr.png)](https://gemnasium.com/anthonator/errawr) [![Coverage Status](https://coveralls.io/repos/anthonator/errawr/badge.png?branch=master)](https://coveralls.io/r/anthonator/errawr?branch=master) [![Code Climate](https://codeclimate.com/github/anthonator/errawr.png)](https://codeclimate.com/github/anthonator/errawr)

## Installation

Add this line to your application's Gemfile:

    gem 'errawr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install errawr

## Usage

### Localizations

Errawr uses [I18n](https://github.com/svenfuchs/i18n) for easily managing error localizations. Just define a locale using the ```errawr``` key.

```yaml
en:
  errawr:
    your_error: Your error message here
```

Need to add more locale files? Use I18n's standard ```load_path```.

```ruby
I18n.load_path += Dir.glob('lib/your_lib/locales/*.{rb,yml}')
```

### Registering Errors

Before you can raise an error you'll need to register it first.

```ruby
Errawr.register!(:your_error)
```

It's also possible to pass in additional metadata when registering an error.

```ruby
Errawr.register!(:bad_request, { http_status: 400 })
begin
  Errawr.error!(:bad_request)
rescue => e
  puts e.context[:http_status]
end
```

### Raising Errors

```ruby
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.message # Localized error message defined in locale file
end
```

### Managing Errors through Locale Files

It's also possible to manage your errors and their metadata purely through locale files.

```yaml
en:
  errawr:
    your_error:
      name: my error
      error:
        message: My awesome error message
```

Then just register and raise your exceptions like normal.

```ruby
Errawr.register!(:your_error)
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.context[:name] # Will return "my error"
end
```

**Note** the ```errawr.your_error.error.message``` locale key. This is the key used to define an error message when managing an error through a locale file.

### Overrides

Want to override that metadata you registered? That's cool too.

```yaml
en:
  errawr:
    your_error:
      name: my error
      error:
        message: My awesome error message
```

```ruby
# #register! overrides metadata defined in the locale file
Errawr.register!(:your_error, name: 'my infamous error')
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.context[:name] # Will return "my infamous error"
end

begin
  # #error! metadata overrides both #register! and the locale file
  Errawr.error!(:your_error, name: 'my very favorite error')
rescue => e
  puts e.context[:name] # Will return "my very favorite error"
end
``` 

**Note** Errawr reserves the ```error``` namespace under an error defined within a locale file. Any data defined under ```error``` will not show up in the raised errors context.

### Custom Error Classes

Want to write a custom error class? No problem!

```ruby
class YourError < Errawr::Error
  def your_method
     ...
  end
end

# Register your error with your custom class
Errawr.register!(:your_error, { error: { base_class: YourError } })

# Do something with it
begin
  Errawr.error!(:your_error)
rescue => e
  e.your_method
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits
[![Sticksnleaves](http://sticksnleaves-wordpress.herokuapp.com/wp-content/themes/sticksnleaves/images/snl-logo-116x116.png)](http://www.sticksnleaves.com)

Errawr is maintained and funded by [Sticksnleaves](http://www.sticksnleaves.com)

Thanks to all of our [contributors](https://github.com/anthonator/errawr/graphs/contributors)