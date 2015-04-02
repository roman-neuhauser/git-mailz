rejects a message with empty body
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
  > Subject: rofl
  > EOF
  $ git mailz random.patch
  fatal: empty body in random.patch
  [1]


  $ cat > random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > Subject: rofl
  > 
  > 
  > 
  > EOF
  $ git mailz random.patch
  fatal: empty body in random.patch
  [1]


test dir
********

::

  $ mkdir dir
  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > Subject: rofl
  > EOF
  $ git mailz dir
  fatal: empty body in dir/random.patch
  [1]


  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > Subject: rofl
  > 
  > 
  > 
  > EOF
  $ git mailz dir
  fatal: empty body in dir/random.patch
  [1]

