requires all arguments to be valid
==================================

setup
*****

::

  $ . $TESTDIR/setup


test
****

::

  $ git mailz $TESTDIR/fixtures/a741380.patch fubar
  git-mailz: error: cannot read fubar
  [1]

::

  $ touch fubar
  $ git mailz $TESTDIR/fixtures/a741380.patch fubar
  git-mailz: error: no sender in fubar
  [1]

::

  $ mkdir snafu
  $ git mailz $TESTDIR/fixtures/a741380.patch snafu
  git-mailz: error: no patches found in snafu
  [1]

