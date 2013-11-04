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

Errawr uses [I18n](https://github.com/svenfuchs/i18n) for easily managing error localizations. Just define a locales using the ```errawr``` key.

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

Then start raising hell!

```ruby
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.message # Localized error message defined in locale file
end
```

Want to override that metadata you registered? That's cool too.

```ruby
Errawr.register!(:bad_request, { http_status: 400 })
begin
  Errawr.error!(:bad_request, { http_status: 500 })
rescue => e
  puts e.context[:http_status] # Will return 500
end
```

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