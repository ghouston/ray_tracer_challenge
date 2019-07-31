# Ray Tracer Challenge (Crystal Language)

Gregory N. Houston

To learn and practice using Crystal language, I've started the Ray Tracer Challenge (book by Pragmatic Pub).

Feedback is welcome.

## Installation

TODO: Write installation instructions here

## Usage

run the specs

```bash
crystal spec
```

Some chapters have exercises which are run separately.  see below.

Work In Progress:
* Chapter 1
  * scope: Point, Vector
  * exercise simulates a projectile, writes report to STDOUT
  * crystal run src/exercises/ch1.cr
* Chapter 2
  * scope: Color, Canvas, PpmWriter
  * exercise simulates a projectile, writes ppm format file
  * crystal run src/exercises/ch2.cr -- <file_path.ppm> # defaults to ch2.ppm
* Chapter 3
  * scope: SquareMatrix
  * no exercise
* Chapter 4
  * scope: Matrix transforms: translation, scaling, rotation, skew.  Fluent chaining of transformations.
  * exercise: TODO.
* Chapter 5
  * scope: Ray, Intersections, Sphere
  * exercise: TODO.
* Chapter 6 - 16
  * TODO.

## Development

TODO: Write about development experience.

I've been happy with the experience learing and using Crystal.
* very easy to learn since I already know ruby.  (much easier than go, rust, and elixir which I've explored recently.)
* the compiler found some unwanted nil/null cases. which I easily eliminated.
* fibers and csp are very easy to use (see adapters/sub_pixel_stream.cr which is responsible for streaming individual elements of an RGB value. adapters/ppm_writer.cr which reads the sub_pixel_stream and handles the rules for formating a PPM file.)
* macros are a lot different than creating code at run-time in ruby. I still need to learn more here. Crystal's documentation for macros needs improving. I was expecting marcos to be a text substitution (similar to C macros).  Instead Crystal macros have a mini-language and they can manipulate the AST.
* the type system works well. Sometimes I had to create similar methods for different argument types or different return types.  Maybe macros could have helped DRY the code here.
* using the book Ray Tracer Challenge for a language learning exercise has worked well. its a well written book. I recommend it.

When developing, use the format tool and ameba:

```bash
crystal tool format && ameba && crystal spec
```

## Contributing

1. Fork it (<https://github.com/your-github-user/ray_tracer_challenge/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Greg Houston](https://github.com/ghouston) - creator and maintainer
