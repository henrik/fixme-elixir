# FIXME for Elixir

FIXME comments that raise after a certain point in time:

``` elixir
defmodule MyCode do
  import FIXME

  def my_function do
    fixme 2015-12-01, "Stop hard-coding currency."
    currency = "USD"
    # …
  end
end
```

Starting December 1st 2015, the "fixme" line in the example above would raise a compile-time exception with the message "Fix by 2015-12-01: Stop hard-coding currency."

You may want to use these bad boys next to:

* Temporary quick fixes, to ensure they really are temporary.
* Code that supports legacy workflows during a transitional period.
* Experiments, to remember to evaluate them and make a decision.
* Anything else you can't do now but should fix later.

They raise at compile time because runtime errors in production are not desirable. Compile time also means that the above example will raise when `my_function` is compiled, even if it's never called.

Note that you need to explicitly `import FIXME` because `FIXME.fixme` can only execute at compile time if it is a macro, and these must be explicitly loaded.

Protip: make sure it's clear from the exception or from a separate comment just what should be done – sometimes not even the person who wrote the quickfix will remember what you're meant to change.


## Installation

Add the dependency to your project's `mix.exs`:

``` elixir
defp deps do
  [
    {:fixme, "~> 0.0.2"},
  ]
end
```

Then fetch it:

```
mix deps.get
```


## Tests

```
mix test
```


## Gotchas

If you see an error like "** (CompileError) lib/foo.ex:2: undefined function fixme/2", you probably forgot to `import FIXME`.


## Also see

* My [fixme Ruby gem](https://github.com/henrik/fixme)


## License

Copyright (c) 2015 Henrik Nyh

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
