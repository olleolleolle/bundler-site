---
title: bundle check
---

## bundle check

Checks if the dependencies listed in Gemfile are satisfied by currently installed gems.

``` bash
$ bundle check [--dry-run] [--gemfile=FILE] [--path=PATH]
```

**Options:**

`--dry-run`: Locks the Gemfile.

`--gemfile`: Use the specified gemfile instead of Gemfile.

`--path`: Specify a different path than the system default `($BUNDLE_PATH or $GEM_HOME)`.
Bundler will remember this value for future installs on this machine.

The `check` command searches the local machine for each of the gems requested in the `Gemfile`. If
all gems are found, Bundler prints a success message and exits with a status of 0.
If not, the first missing gem is listed and Bundler exits status 1.
