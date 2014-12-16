# csync2

[![Latest Version](http://img.shields.io/github/release/adamkrone/chef-csync2.svg?style=flat-square)][release]
[![Build Status](http://img.shields.io/travis/adamkrone/chef-csync2.svg?style=flat-square)][build]
[![Coverage Status](http://img.shields.io/coveralls/adamkrone/chef-csync2.svg?style=flat-square)][coverage]

[release]: https://github.com/adamkrone/chef-csync2/releases
[build]: https://travis-ci.org/adamkrone/chef-csync2
[coverage]: https://coveralls.io/r/adamkrone/chef-csync2

Installs and configures [csync2](http://oss.linbit.com/csync2/). Currently in an
early prototype stage with minimal flexibility.

## Supported Platforms

_More thorough platform testing will be completed once this cookbook takes shape._

- Ubuntu 14.04

## Attributes

None at the moment.

## Recipes

### default

Installs the csync package.


## Definitions

### csync2_config

Adds configuration for csync2 replication.

Example:

```ruby
csync2_config '/etc/csync2.cfg' do
  hosts [
    {name: 'web01', ip_address: '192.168.33.11'},
    {name: 'web02', ip_address: '192.168.33.12'},
    {name: 'web03', ip_address: '192.168.33.13'}
  ]
end
```

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
