requires all arguments to be valid
==================================

setup
*****

::

  $ . $TESTDIR/tools.sh


test
****

::

  $ git mailz $TESTDIR/a741380.patch fubar
  fatal: cannot read fubar
  [1]

::

  $ touch fubar
  $ git mailz $TESTDIR/a741380.patch fubar
  fatal: no sender in fubar
  [1]

::

  $ mkdir snafu
  $ git mailz $TESTDIR/a741380.patch snafu
  fatal: no patches found in snafu
  [1]

