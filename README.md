weatherzone
===========

http://github.com/benaskins/weatherzone/

DESCRIPTION
-----------

Ruby client for the weatherzone webservice.

How to use
----------

In order to use this gem you will require credentials for the Weatherzone 
Web Service: http://business.weatherzone.com.au

You will need to create a proc or lambda which will generate the key used in the authentication
process - for details on the algorithm required you will need to consult the documentation
provided to weatherzone clients. An example is as follows:

    keygen = Proc.new { (1 + 2 + 3 * 1000) } # Apply the weatherzone specific algorithm in here

First, setup your connection - this can be done in an initializer if you are using this gem
within a Rails application:

    require 'logger'
    WEATHERZONE = Weatherzone::Connection.new("username", "password", :keygen => keygen)

or

    WEATHERZONE = Weatherzone::Connection.new("username", "password", :keygen => keygen)

Once this is done you can then query against the web service:

    @location = Weather.find_by_location_name(WEATHERZONE, "Sydney")

LICENSE
-------

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
