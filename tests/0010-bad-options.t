bad options
===========

setup
*****

::

  $ . $TESTDIR/setup


test an unknown short
*********************

::

  $ git mailz -x
  git-mailz: error: unknown option -x
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test an unknown long
********************

::

  $ git mailz --bar
  git-mailz: error: unknown option --
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]

test -f with no optarg
**********************

::

  $ git mailz -f
  git-mailz: error: option -f requires an argument
  usage: git-mailz [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...
  [1]
