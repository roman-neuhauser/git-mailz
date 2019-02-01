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
  git-mailz: error: cannot read fubar
  [1]

test file
*********

::

  $ touch empty-file
  $ git mailz empty-file
  git-mailz: error: no sender in empty-file
  [1]


test dir
********

::

  $ mkdir dir
  $ touch dir/empty-file
  $ git mailz dir
  git-mailz: error: no sender in dir/empty-file
  [1]


test with an empty directory
****************************

::

  $ mkdir snafu
  $ git mailz snafu
  git-mailz: error: no patches found in snafu
  [1]

::

  $ mkdir -p snafu
  $ git mailz -f git-mailz-tests@example.org snafu
  git-mailz: error: no patches found in snafu
  [1]

test with *two* empty directories
*********************************

::

  $ mkdir -p snafu fubar
  $ git mailz snafu fubar
  git-mailz: error: no patches found in snafu
  [1]

