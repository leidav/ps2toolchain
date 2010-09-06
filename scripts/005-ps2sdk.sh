#!/bin/sh
# ps2sdk.sh by Dan Peori (danpeori@oopo.net)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

 ## Download the source code.
 if test ! -d "ps2sdk"; then
  git clone git://github.com/ps2dev/ps2sdk.git && cd ps2sdk || exit 1
 else
  cd ps2sdk && git pull || exit 1
 fi

 ## Build and install.
 make clean && make -j 2 && make release && make clean || { exit 1; }

 ## Replace newlib's crt0 with the one in ps2sdk.
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/lib/gcc-lib/ee/3.2.2/crt0.o" || { exit 1; }
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/ee/lib/crt0.o" || { exit 1; }
