#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

function complain # {{{
{
  local -r ex=$1 fmt=$2; shift 2
  print -u 2 -f "fatal: "
  print -u 2 -f "$fmt\n" "$@"
  [[ $ex != - ]] && exit $ex
} # }}}

function check-patch # {{{
{
  local line patch=$1
  local -i content=0 recipients=0 sender=0 stage=0 subject=0
  while read line; do
    if (( stage == 0 )); then
      if [[ -z $line ]]; then stage=1; continue; fi
      if [[ $line =~ '^(From): .+' ]]; then sender=1; fi
      if [[ $line =~ '^(To|Cc): .+' ]]; then recipients=1; fi
      if [[ $line =~ '^(Subject): .+' ]]; then subject=1; fi
    else
      if [[ $line =~ '.*[^[:space:]].*' ]]; then content=1; break; fi
    fi
  done <$patch
  (( sender )) || complain 1 "no sender in $patch"
  (( recipients )) || complain 1 "no recipients in $patch"
  (( subject )) || complain 1 "no subject in $patch"
  (( content )) || complain 1 "empty body in $patch"
} # }}}

set -o no_unset
set -o err_return

declare -r _SELF=${0##*/}

declare -r sendmail=${GIT_MAILZ_SENDMAIL:-${$(git config --get mailz.sendmail):-sendmail}}

set -A sendmail_args -i -t

while [[ $# -gt 0 && $1 == -* ]]; do
  case $1 in
  -f) sendmail_args+=($1 $2); shift ;;
  -t) ;; # default
  --) shift; break ;;
  esac
  shift
done

if (( $# == 0 )); then
  print -u 2 "usage: $_SELF [-f ENVELOPE-SENDER] <FILE|DIRECTORY>..."
  exit 1
fi

declare -a patches argexpn

for arg in "$@"; do
  if [[ -d $arg ]]; then
    argexpn=($arg/**/*(N.))
  else
    argexpn=($arg)
  fi
  if (( $#argexpn == 0 )); then
    complain 1 "no patches found in $arg"
  fi
  patches+=($argexpn)
done

for patch in "${(@)patches}"; do
  if [[ ! -e $patch ]]; then
    complain 1 "cannot read $patch"
  fi
  check-patch $patch
done

for patch in "${(@)patches}"; do
  $sendmail "${(@)sendmail_args}" <$patch \
  || complain $? "failed ${(qq)sendmail} ${(@qq)sendmail_args} < ${(qq)patch}"
done
