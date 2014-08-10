# YYMMDD

Tiny DSL for idiomatic date parsing and formatting.

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

When given a `String` it will attempt to parse it as the specified format and return a `Date`.

When given a `Date` it will return a `String` in the specified format.

An `ArgumentError` is raised if the date can't be parsed or formatted.

With no arguments it will return an instance of a `String`-like object representing today's date in the specified format
(it overrides `to_s` and `to_str`). In the most common cases you can treat it like a `String`:

    date = yyyy/mm/dd
	puts "Today's date: #{date}"
    text = ["Dates: ", yy/mm, yyyy/mm].join(", ")
	text = "A great date: " << date

But in some instances you'll have to expilictly call `to_s`:

    printf "Today's date: %s\n", date.to_s

All the heavy lifting is done by `Date#strftime` and `Date.strptime`.

### Format Specifiers

The table below lists the available format specifiers. All of these can be separated by one of the supported
delimiters; `"/"`, `"."`, or `"-"`.

<table>
  <thead>
	<th>Name</th><th>Format</th>
  </thead>
  <tbody>
	<tr>
	  <td><code>d</code></td><td>day of the year, no 0 padding</td>
	</tr>
	<tr>
	  <td><code>dd</code></td><td>day of the year</td>
	</tr>
	<tr>
	  <td><code>m</code></td><td>day of the month, no 0 padding</td>
	</tr>
	<tr>
	  <td><code>mm</code></td><td>day of the month</td>
	</tr>
	<tr>
	  <td><code>y</code></td><td>2 digit year</td>
	</tr>
	<tr>
	  <td><code>yy</code></td><td>2 digit year</td>
	</tr>
	<tr>
	  <td><code>yyyy</code></td><td>4 digit year</td>
	</tr>
  </tbody>
</table>

## Caveats

Due to operator precedence you can't mix delimiters.

## Author

Skye Shaw [sshaw AT gmail.com]

## License

Released under the MIT License: www.opensource.org/licenses/MIT
