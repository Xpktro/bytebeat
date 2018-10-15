#!/bin/bash
# Copyright 2018 Moisés Cachay
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

filename="$(pwd)/output.wav"
duration=10
beatfile="$(mktemp /tmp/bytebeat.XXXXXX).c"
beatexec=$(mktemp /tmp/bytebeat.XXXXXX)

trap ctrl_c INT
ctrl_c() {
  rm "$beatfile"
  rm "$beatexec"
}

print_help() {
  echo "Usage: $0 BYTESTRING [-e|--export [-f|--filename FILENAME] [-d|--duration DURATION]]
   BYTESTRING        Bytebeat string to render (being t = time)
   -e, --export      Export rendered audio (no sound output)
   -f, --filename    Exported audio filename (defaults to output.wav)
   -d, --duration    Exported audio duration (defaults to 10 seconds)"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help) print_help;;
    -e|--export) export=true; shift 1;;
    -f|--filename) filename="$2"; shift 2;;
    -d|--duration) duration="$2"; shift 2;;

    -*|--*) echo "Unknown option: $1"; print_help; exit 1;;
    *) program=$1; shift 1;;
  esac
done

if [ -z "$program" ]
then
  print_help; exit 1
fi

if [ -z "$export" ]
then
  # XXX: Shouldn't work in linux, PRs are welcome :)
  target="-tcoreaudio"
else
  target="$filename trim 0 $duration"
fi

echo "Rendering: $program"

echo -e "#include <stdio.h>\nint main(){int t; for(t=0;;t++){putchar($program);}}" > "$beatfile"
gcc $beatfile -o $beatexec
$beatexec | sox -v 0.5 -traw -r8000 -b8 -e unsigned-integer - $target
