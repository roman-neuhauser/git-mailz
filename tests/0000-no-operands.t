requires at least one patch
===========================

setup
*****

::

  $ . $TESTDIR/setup


test with no arguments
**********************

::

  $ git mailz
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test with -f, no operands
*************************

::

  $ git mailz -f git-mailz-tests@example.org
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

