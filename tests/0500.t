accepts a message with a sender, recipients and nonempty body
=============================================================

setup
*****

::

  $ . $TESTDIR/tools.sh


test a file argument
********************

::

  $ git mailz $TESTDIR/a741380.patch
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
  |---
  | .gitignore | 5 +++++
  | 1 file changed, 5 insertions(+)
  | create mode 100644 .gitignore
  |
  |diff --git a/.gitignore b/.gitignore
  |new file mode 100644
  |index 0000000..cd7865f
  |--- /dev/null
  |+++ b/.gitignore
  |@@ -0,0 +1,5 @@
  |+.sw?
  |+.*.sw?
  |+*.gz
  |+*.html
  |+/git-mailz
  |-- 
  |2.0.4
  |


test a dir argument
*******************

::

  $ mkdir dir
  $ cp $TESTDIR/a741380.patch dir/
  $ git mailz dir
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
  |---
  | .gitignore | 5 +++++
  | 1 file changed, 5 insertions(+)
  | create mode 100644 .gitignore
  |
  |diff --git a/.gitignore b/.gitignore
  |new file mode 100644
  |index 0000000..cd7865f
  |--- /dev/null
  |+++ b/.gitignore
  |@@ -0,0 +1,5 @@
  |+.sw?
  |+.*.sw?
  |+*.gz
  |+*.html
  |+/git-mailz
  |-- 
  |2.0.4
  |

