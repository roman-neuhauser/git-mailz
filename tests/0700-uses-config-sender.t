recognizes mailz.sender configuration
=====================================

setup
*****

::

  $ . $TESTDIR/setup
  $ git config --global mailz.sender fubar@example.net

test
****

GIT_MAILZ_SENDER takes precedence over mailz.sender:

::

  $ GIT_MAILZ_SENDER=snafu@example.net git mailz $TESTDIR/fixtures/a741380.patch
  git-sendmail arguments:
    -i
    -t
    -f
    snafu@example.net
  git-sendmail stdin:
  |From a741380de7b5fd79f8d3a7dcfcf24a3326203fa5 Mon Sep 17 00:00:00 2001
  |From: Roman Neuhauser <rneuhauser@suse.cz>
  |Date: Tue, 26 Aug 2014 13:30:59 +0200
  |Subject: [PATCH] basic .gitignore
  |To: git-mailz-tests@example.org
  |

with no GIT_MAILZ_SENDER blocking the view:

::

  $ unset GIT_MAILZ_SENDER
  $ git mailz $TESTDIR/fixtures/a741380.patch
  git-sendmail arguments:
    -i
    -t
    -f
    fubar@example.net
  git-sendmail stdin:
  |From a741380de7b5fd79f8d3a7dcfcf24a3326203fa5 Mon Sep 17 00:00:00 2001
  |From: Roman Neuhauser <rneuhauser@suse.cz>
  |Date: Tue, 26 Aug 2014 13:30:59 +0200
  |Subject: [PATCH] basic .gitignore
  |To: git-mailz-tests@example.org
  |

