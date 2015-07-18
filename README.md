# Errawr

A framework for effectively defining and raising localized errors.

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

Errawr uses [I18n](https://github.com/svenfuchs/i18n) for easily managing error
localizations. Just define an error in a locale file. Make sure to use the
```errawr``` key.

```yaml
en:
  errawr:
    your_error: Your error message here
```

Need to add more locale files? Use I18n's standard ```load_path```.

```ruby
I18n.load_path += Dir.glob('lib/your_lib/locales/*.{rb,yml}')
```

### Raising Errors

```ruby
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.message # Localized error message defined in locale file
end
```

### Metadata

It's possible to add additional information to a registered error through
metadata. Just specify a ```metadata``` hash when throwing an error:

```ruby
begin
  Errawr.error!(:your_error, metadata: { http_status: 400 })
rescue => e
  puts e.metadata[:http_status] # Will return 400
end
```

### Managing Errors through Locale Files

It's also possible to manage your errors and their metadata purely through locale files.

```yaml
en:
  errawr:
    your_error:
      message: My awesome error message
      metadata:
        http_status: 400
```

Then just raise your exceptions like normal.

```ruby
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.metadata[:http_status] # Will return 400
end
```

### I18n Interpolation

You can pass in parameter values to your localized error messages.

```yaml
en
  errawr:
  your_error:
    message: "My awesome error message is: %{error_message}"
```

```ruby
begin
  Errawr.error!(:your_error, error_message: 'You did it wrong!')
rescue => e
  puts e.message # Will return "My awesome error message is: You did it wrong!"
end
```

### Overrides

It's possible to override metadata stored in a locale file both globally and
on a per use basis.

```yaml
en:
  errawr:
    your_error:
      message: My awesome error message
      metadata:
        http_status: 400
```

The ```#register!``` method will override the locale file.

```ruby
Errawr.register!(:your_error, message: 'Some other error message', metadata: { http_status: 403 })
begin
  Errawr.error!(:your_error)
rescue => e
  puts e.message # => Will return "Some other error message"
  puts e.metadata[:http_status] # => Will return 403
end
```

The ```#error!``` method will override both ```#register!``` and the locale file.

```ruby
Errawr.register!(:your_error, message: 'Some other error message', metadata: { http_status: 403 })
begin
  Errawr.error!(:your_error, message: 'Yet another error message', metadata: { http_status: 404 })
rescue => e
  puts e.message # => Will return "Yet another error message"
  puts e.metadata[:http_status] # => Will return 404
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
Errawr.register!(:your_error, base_class: YourError)

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
