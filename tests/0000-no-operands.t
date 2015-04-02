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
  git-mailz: error: missing operand
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test with -f, no operands
*************************

::

  $ git mailz -f git-mailz-tests@example.org
  git-mailz: error: missing operand
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test with -h, no operands
*************************

::

  $ git mailz -h
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
    Options:
      -h                    Display this message
      -f ENVELOPE-SENDER    Invoke mailz.sendmail with -f ENVELOPE-SENDER
