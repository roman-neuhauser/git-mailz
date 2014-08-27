requires at least one patch
===========================

setup
*****

::

  $ . $TESTDIR/tools.sh


test with no arguments
**********************

::

  $ git mailz
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test with an empty directory
****************************

::

  $ mkdir snafu
  $ git mailz snafu
  fatal: no patches found in snafu
  [1]

test with *two* empty directories
*********************************

::

  $ mkdir -p snafu fubar
  $ git mailz snafu fubar
  fatal: no patches found in snafu
  [1]

