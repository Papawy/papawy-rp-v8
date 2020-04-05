# pwyrp

[![Build Status](https://travis-ci.org/Papawy/papawy-rp-v8.svg?branch=master)](https://travis-ci.org/Papawy/papawy-rp-v8)

## Building

```
sampctl package build prod
```

## Installation

Just the resulting `.amx` file into your `gamemodes` folder.
You can convert the `pawn.json` runtime part into a `samp.json` as explained in sampctl documentation.

## Usage

If you have a `samp.json`:

```
sampctl server init
sampctl server ensure
sampctl server run
```
