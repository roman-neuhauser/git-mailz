rejects a message with no subject
=================================

setup
*****

::

  $ . $TESTDIR/setup


test file
*********

::

  $ cat > random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > EOF
  $ git mailz random.patch
  git-mailz: error: no subject in random.patch
  [1]


test dir
********

::

  $ mkdir dir
  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > EOF
  $ git mailz dir
  git-mailz: error: no subject in dir/random.patch
  [1]

