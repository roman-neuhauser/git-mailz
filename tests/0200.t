rejects a message with no recipients
====================================

setup
*****

::

  $ . $TESTDIR/tools.sh


test file
*********

::

  $ cat > random.patch <<'EOF'
  > From: fubar@example.org
  > EOF
  $ git mailz random.patch
  fatal: no recipients in random.patch
  [1]


test dir
********

::

  $ mkdir dir
  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > EOF
  $ git mailz dir
  fatal: no recipients in dir/random.patch
  [1]

