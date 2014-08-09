# YYMMDD

Small DSL for idiomatic date parsing and formatting.

## Overview

    require "yymmdd"

    include YYMMDD

    puts yy/mm              # 14/08 (i.e., today's date)
    puts yyyy/mm            # 2014/08
    date = ymd(411207)      # Date.new(1941, 12, 7)

    date = Date.today
    puts ymd(date)          # 140809
    puts yyyy.mm.dd(date)   # 2014.08.09
    puts dd/mm/yy(date)     # 08/09/14

    date = yyyy.mm.dd("1941.12.07")  # Date.new(1941, 12, 7)
    date = mm.dd.yy("11.22.63")      # Date.new(1963, 11, 22)
    date = mm/dd/yy("11/21/99")      # ...
    date = mm/dd/yyyy("11/21/1999")
    date = mm-dd-yyyy("11-21-1999")
    date = m-d-y("11-21-99")

## Installation

### Rubygems:

    gem install yymmdd

### Bundler:

    gem "yymmdd"

## Usage

All functions are [`module_function`s](http://www.ruby-doc.org/core-2.1.2/Module.html#method-i-module_function)
so you must `include YYMMDD` to use them.

With no arguments it will return a `String` representing today's date in the specified format.

When given a `String` it will attempt to parse it as the specified format and return a `Date`.

When given a `Date` it will return a `String` in the specified format.

An `ArgumentError` is raised if the date can't be parsed or formatted.

All the heavy lifting is done by `Date#strftime` and `Date.strptime`.

## Caveats

Due to operator precedence you can't mix delimiters.

## Author

Skye Shaw [sshaw AT gmail.com]

## License

Released under the MIT License: www.opensource.org/licenses/MIT
