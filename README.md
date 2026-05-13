# makscee homebrew tap

Personal tap. Two formulas:

- `void-os` — local agent OS daemon + `void-os init` CLI.
- `claudev` — POSIX shell wrapper around `claude` that pulls pool OAuth tokens.

## Install

~~~
brew tap makscee/tap
brew install makscee/tap/void-os
~~~

## Notes

Both formulas are head-only and track upstream `main` / `master`. `brew upgrade` pulls fresh HEAD on every run.
