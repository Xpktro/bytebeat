# bytebeat.sh
A small bash script for listeting to and saving [bytebeats](https://creators.vice.com/en_us/article/qkzakx/meet-bytebeat-a-brand-new-electronic-music-genre).

# Requirements
_Note: This has been tested and written in OSX, linux support can be done with little or no changes. PRs are always welcome._

For this script to work you must install (besides bash which is already included in your OS):

- [GCC](https://gcc.gnu.org/)
- [SoX](http://sox.sourceforge.net/)

Installation will vary depending on your OS but it should be pretty simple. Check for [homebrew](https://brew.sh/) in OSX or your favorite linux package manager, they should include ready-made packages for both dependencies.

# Installation
Once you downloaded and installed the dependencies, just clone this repo and/or download/copy the `bytebeat.sh` file in whatever folder you have write permissions for :)

# Usage
Executing `bytebeat.sh` without any argument will show its help message.

For listening to a bytebeat, just pass its formula to the script:
```
./bytebeat.sh "(t%255&t)-(t>>13&t)"
```
_Note: currently nothing more than t (the time-changing variable) and the usual aritmethic/bitwise operations are supported._

If you want to save your bytebeat to a file, use the `-e|--export` option.
```
./bytebeat.sh "(t%255&t)-(t>>13&t)" --export
```

By default it will use `output.wav` as the name for the resulting sound file. You can specify this name using the `-f|--filename` option.
```
./bytebeat.sh "(t%255&t)-(t>>13&t)" --export -f bytebeat.wav
```

Exported files will contain 10 seconds of audio by default. You can change this audio length by using the `-d|--duration` option.
```
./bytebeat.sh "(t%255&t)-(t>>13&t)" --export -f bytebeat.wav --duration 5
```

# License
    Copyright 2018 Moisés Cachay

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
