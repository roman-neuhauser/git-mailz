requires at least one patch
===========================

setup
*****

::

  $ . $TESTDIR/tools.sh


test with no arguments
**********************

  $ git mailz
  fatal: no patches to send
  [1]

test with a nonexistent argument
********************************

  $ git mailz fubar
  fatal: cannot read fubar
  [1]

test with an empty directory argument
*************************************

  $ mkdir snafu
  $ git mailz snafu
  fatal: no patches to send
  [1]

