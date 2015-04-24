recognizes mailz.sendmail configuration
=======================================

setup
*****

::

  $ . $TESTDIR/setup
  $ git config --global mailz.sendmail $PWD/fake
  $ cat >$PWD/fake <<'EOF'
  > #!/bin/sh
  > echo HELLO WORLD
  > EOF
  $ chmod u+x $PWD/fake

test
****

GIT_MAILZ_SENDMAIL takes precedence over mailz.sendmail:

::

  $ git mailz $TESTDIR/fixtures/a741380.patch
  git-sendmail arguments:
    -i
    -t
  git-sendmail stdin:
  |From a741380de7b5fd79f8d3a7dcfcf24a3326203fa5 Mon Sep 17 00:00:00 2001
  |From: Roman Neuhauser <rneuhauser@suse.cz>
  |Date: Tue, 26 Aug 2014 13:30:59 +0200
  |Subject: [PATCH] basic .gitignore
  |To: git-mailz-tests@example.org
  |

with no GIT_MAILZ_SENDMAIL blocking the view:

::

  $ unset GIT_MAILZ_SENDMAIL
  $ git mailz $TESTDIR/fixtures/a741380.patch
  HELLO WORLD

