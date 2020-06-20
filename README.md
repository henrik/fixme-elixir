# FIXME for Elixir

[![Build Status](https://travis-ci.org/henrik/fixme-elixir.svg?branch=master)](https://travis-ci.org/henrik/fixme-elixir)
[![Hex](https://img.shields.io/hexpm/v/fixme.svg)](https://hex.pm/packages/fixme)

FIXME comments that raise during compilation after a certain point in time:

``` elixir
defmodule MyCode do
  import FIXME

  def my_function do
    fixme 2020-12-01, "Stop hard-coding currency."
    currency = "USD"
    # …
  end
end
```

Starting December 1st 2020, the `fixme` line in the example above would raise a compile-time exception with the message "Fix by 2020-12-01: Stop hard-coding currency."

Optionally, you can also get warnings before that date, reminding you it's coming up.

You may want to use these bad boys next to:

* Temporary quick fixes, to ensure they really are temporary.
* Code that supports legacy workflows during a transitional period.
* Experiments, to remember to evaluate them and make a decision.
* Anything else you can't do now but should fix later.

They raise *at compile time* because runtime errors in production are not desirable. Compile time also means that the above example will raise when `my_function` is compiled, even if it's never called.

Another consequence of running at compile time is that if the date passes and the file is not recompiled, there will be no exception. You can either accept that (maybe untouched code can remain that way until the next time), or you can `mix compile --force`. Or make your case for runtime support: maybe it should be added?

Note that you need to explicitly `import FIXME` because `fixme` is a macro.

Protip: make sure it's clear from the exception or from a separate comment just what should be done – sometimes not even the person who wrote the quickfix will remember what you're meant to change.


## Warnings before the due date

You can opt into warnings before the due date arrives – but you'll still get exceptions on and after the date.

The warnings look like:

    warning: Fix by 2020-12-01: Stop hard-coding currency.
      lib/my_code.ex:5

You can configure this either application-wide or per `fixme` call.

If you want it application-wide, do this in your `config/config.exs`:


```elixir
config :fixme, warn: true
```

To specify it per call:

```elixir
fixme 2020-12-01, "Stop hard-coding currency.", warn: true
```

This overrides the application-wide setting, so you can selectively opt into warnings for some FIXMEs, or opt out of some if the application-wide setting is to show them.


## Gotchas

If you see an error like "** (CompileError) lib/foo.ex:2: undefined function fixme/2", you probably forgot to `import FIXME`.


## Installation

Add the dependency to your project's `mix.exs`:

``` elixir
defp deps do
  [
    {:fixme, "> 0.0.0"},
  ]
end
```

Then fetch it:

    mix deps.get


## Tests

If you're developing this library, you can run its tests with:

    mix test

CI runs the tests against multiple Elixir versions. See `.travis.yml`. The policy is to test against [every version that still receives security patches](https://hexdocs.pm/elixir/compatibility-and-deprecations.html).

## Also see

* [Blocked](https://github.com/Qqwy/elixir-blocked), which triggers on GitHub issues rather than dates
* My ["fixme" Ruby gem](https://github.com/henrik/fixme)


## License

Copyright (c) 2015+ Henrik Nyh

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
