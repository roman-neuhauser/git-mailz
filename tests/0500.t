accepts a message with a sender, recipients and nonempty body
=============================================================

setup
*****

::

  $ . $TESTDIR/tools.sh


test file
*********

  $ cat > random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > Subject: rofl
  > 
  > lmao
  > EOF
  $ git mailz random.patch
  git-sendmail arguments:
    -i
    -t
  git-sendmail stdin:
  |From: fubar@example.org
  |Cc: snafu@example.org
  |Subject: rofl
  |
  |lmao


test dir
********

  $ mkdir dir

  $ cat > dir/random.patch <<'EOF'
  > From: fubar@example.org
  > Cc: snafu@example.org
  > Subject: rofl
  > 
  > lmao
  > EOF
  $ git mailz dir/random.patch
  git-sendmail arguments:
    -i
    -t
  git-sendmail stdin:
  |From: fubar@example.org
  |Cc: snafu@example.org
  |Subject: rofl
  |
  |lmao

