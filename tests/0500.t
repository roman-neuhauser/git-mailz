  $ . $TESTDIR/setup
  $ DUMP_INPUTS_FULL=1 git mailz $TESTDIR/a741380.patch
  $ git mailz $TESTDIR/fixtures/v0.3..82411a
  |From 228a40ae54b48cd3ba95372640a95680e1da2ed0 Mon Sep 17 00:00:00 2001
  |Date: Tue, 26 Aug 2014 18:20:15 +0200
  |Subject: [PATCH 1/3] without erroneous quotes in error-handling code
  git-sendmail arguments:
    -i
    -t
  git-sendmail stdin:
  |From 62b1157a47a18b4a689d1574717ff9d2f1422f30 Mon Sep 17 00:00:00 2001
  |From: Roman Neuhauser <rneuhauser@suse.cz>
  |Date: Tue, 26 Aug 2014 18:21:04 +0200
  |Subject: [PATCH 2/3] README, manpage: SEE ALSO sections mention sendmail
  |To: git-mailz-tests@example.org
  git-sendmail arguments:
    -i
    -t
  git-sendmail stdin:
  |From 82411a9ecb75b79e6e610a881c130f99b30e0c49 Mon Sep 17 00:00:00 2001
  |From: Roman Neuhauser <rneuhauser@suse.cz>
  |Date: Tue, 26 Aug 2014 20:05:10 +0200
  |Subject: [PATCH 3/3] README: markup fixes
  |To: git-mailz-tests@example.org