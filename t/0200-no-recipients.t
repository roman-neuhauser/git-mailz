rejects a message with no recipients
====================================

setup
*****

::

  $ . $TESTDIR/setup


test file
*********

::

  $ cat > random.patch <<'EOF'
  > From: fubar@example.org
  > EOF
  $ git mailz random.patch
  git-mailz: error: no recipients in random.patch
  [1]


test dir
********

::

  $ mkdir dir
  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > EOF
  $ git mailz dir
  git-mailz: error: no recipients in dir/random.patch
  [1]

