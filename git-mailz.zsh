#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

function usage # {{{
{
  local self="$_SELF" exit=${1?} fd=1
  shift
  test $exit -ne 0 && fd=2
  {
    if (( exit == 1 )); then
      print -f "%s: error: option -%c requires an argument\n" -- "$self" "$1"
    elif (( exit == 2 )); then
      print -f "%s: error: unknown option -%s\n" -- "$self" "$1"
    elif (( exit == 3 )); then
      print -f "%s: error: missing operand\n" -- "$self"
    fi
    print -f "usage: %s [-f ENVELOPE-SENDER] <FILE|DIRECTORY>...\n" -- "$self"
    if (( exit == 0 )); then
      print -f "  Options:\n"
      print -f "    %-20s  %s\n" -- \
        "-h"        "Display this message" \
        "-f ENVELOPE-SENDER" \
                    "Invoke mailz.sendmail with -f ENVELOPE-SENDER" \

    fi
  } >&$fd
  exit $(( exit != 0 ))
} # }}}

function complain # {{{
{
  local -r ex=$1 fmt=$2; shift 2
  local banner="%s: error: "
  if (( 111 == ex )); then
    banner="%s: internal error: "
  fi
  print -u 2 -f $banner $_SELF
  print -u 2 -f "$fmt\n" -- "$@"
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

declare -r sendmail=${GIT_MAILZ_SENDMAIL:-${$(git config --get mailz.sendmail):-/usr/sbin/sendmail}}
declare sender=${GIT_MAILZ_SENDER:-$(git config --get mailz.sender)}

declare optname
while getopts :f:h optname; do
  case $optname in
  f) sender=$OPTARG ;;
  h) usage 0 ;;
  :) usage 1 $OPTARG ;;
 \?) usage 2 $OPTARG ;;
  ?) complain 111 "unhandled option -$optname" ;;
  esac
done; shift $((OPTIND - 1))

(( $# > 0 )) || usage 3

declare -a patches argexpn
set -A sendmail_args -i -t

if [[ -n $sender ]]; then
  sendmail_args+=(-f $sender)
fi

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
