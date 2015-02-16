rejects an empty or nonexistent argument
========================================

setup
*****

::

  $ . $TESTDIR/setup


test a nonexistent argument
***************************

::

  $ git mailz fubar
  fatal: cannot read fubar
  [1]

test file
*********

::

  $ touch empty-file
  $ git mailz empty-file
  fatal: no sender in empty-file
  [1]


test dir
********

::

  $ mkdir dir
  $ touch dir/empty-file
  $ git mailz dir
  fatal: no sender in dir/empty-file
  [1]

