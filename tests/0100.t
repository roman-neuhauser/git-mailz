rejects an empty message
========================

setup
*****

::

  $ . $TESTDIR/tools.sh


test file
*********

  $ touch empty-file
  $ git mailz empty-file
  fatal: no sender in empty-file
  [1]


test dir
********

  $ mkdir dir
  $ touch dir/empty-file
  $ git mailz dir
  fatal: no sender in dir/empty-file
  [1]

