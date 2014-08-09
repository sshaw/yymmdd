# YYMMDD

Small DSL for idiomatic date parsing and formatting.

## Overview

    require "yymmdd"

    include YYMMDD

    puts yy/mm        # Today's date 
    puts ymd(411207)

    date = Date.today
    puts ymd(date)
    puts yyyy.mm.dd(date)
    puts dd/mm/yy(date)

    puts yyyy.mm.dd("1941.12.07")
    puts mm.dd.yy("11.22.63")
    puts mm/dd/yy("11/21/99")
    puts mm/dd/yyyy("11/21/1999")
    puts mm-dd-yyyy("11-21-1999")
    puts m-d-y("11-21-99")

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

All the heavy lifting is done by `Date#strftime` and `Date.strptime`.

## Caveats

Due to operator precedence you can't mix delimiters.

## Author

Skye Shaw [sshaw AT gmail.com]

## License

Released under the MIT License: www.opensource.org/licenses/MIT



