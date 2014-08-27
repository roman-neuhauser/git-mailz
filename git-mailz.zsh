#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

function o
{
  print >&2 "$@"
  "$@"
}

set -o no_unset
set -o err_return

declare -r sendmail=${GIT_MAILZ_SENDMAIL:-sendmail}

set -A sendmail_args -i -t

while [[ $# -gt 0 && $1 == -* ]]; do
  case $1 in
  -f) sendmail_args+=($1 $2); shift ;;
  -t) ;; # default
  --) shift; break ;;
  esac
  shift
done

function complain # {{{
{
  print ${@[2,-1]} >&2
  exit $1
} # }}}

function check-patch # {{{
{
  local line patch=$1
  local -i content=0 recipients=0 sender=0 stage=0 subject=0
  while read line; do
    if [[ -z $line ]]; then stage=1; continue; fi
    if (( stage == 0 )); then
      if [[ $line =~ '^(From): .+' ]]; then sender=1; fi
      if [[ $line =~ '^(To|Cc): .+' ]]; then recipients=1; fi
      if [[ $line =~ '^(Subject): .+' ]]; then subject=1; fi
    else
      if [[ $line =~ '.*[^[:space:]].*' ]]; then content=1; break; fi
    fi
  done <$patch
  (( sender )) || complain 1 "fatal: no sender in $patch"
  (( recipients )) || complain 1 "fatal: no recipients in $patch"
  (( subject )) || complain 1 "fatal: no subject in $patch"
  (( content )) || complain 1 "fatal: empty body in $patch"
} # }}}

if (( $# == 0 )); then
  complain 1 "usage: ${0##*/} [-f ENVELOPE-SENDER] <FILE|DIRECTORY>..."
fi

declare -a patches argexpn

for arg in "$@"; do
  if [[ -d $arg ]]; then
    argexpn=($arg/**/*(N.))
  else
    argexpn=($arg)
  fi
  if (( $#argexpn == 0 )); then
    complain 1 "fatal: no patches found in $arg"
  fi
  patches+=$argexpn
done

for patch in "${(@)patches}"; do
  if [[ ! -e $patch ]]; then
    complain 1 "fatal: cannot read $patch"
  fi
  check-patch $patch
done

for patch in "${(@)patches}"; do
  $sendmail "${(@)sendmail_args}" <$patch \
  || complain $? "fatal: failed ${(qq)sendmail} ${(@qq)sendmail_args} < ${(qq)patch}"
done
