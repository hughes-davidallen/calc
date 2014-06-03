#!/bin/sh

# This files shamelessly copied from
# http://caml.inria.fr/pub/docs/manual-ocaml-400/manual032.html

set -e

TARGET=calc
FLAGS=
OCAMLBUILD=ocamlbuild

ocb() {
  $OCAMLBUILD $FLAGS $*
}

rule() {
  case $1 in
    clean)   ocb -clean;;
    native)  ocb $TARGET.native;;
    byte)    ocb $TARGET.byte;;
    all)     ocb $TARGET.native $TARGET.byte;;
    depend)  echo "Not needed.";;
    *)       echo "Unknown action $1";;
  esac;
}

if [ $# -eq 0 ]; then
  rule all
else
  while [ $# -gt 0 ]; do
    rule $1;
    shift
  done
fi
