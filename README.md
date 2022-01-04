 # mupen64plus-web
Revived fork of [johnoneil's Emscripten based web port of Mupen64plus N64 Emulator](https://github.com/johnoneil/mupen64plus-web), with additional changes from [jquesnelle's fork](https://github.com/jquesnelle/mupen64plus-ui-console/tree/emscripten) as well to statically link the different modules. Complete with Netplay Support.

![demo image of mupen64plus in browser](https://raw.githubusercontent.com/johnoneil/mupen64plus-web/master/img/Screenshot%20from%202015-12-19%2016%3A02%3A03.png)

# Building
If you have the Emscripten SDK installed (https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html) you should be able to build via:
* ```make config=release```

Debug build config is also available (i.e. ```make config=debug ...```

This project is known to build well with emscripten 2.0.16.

# Usage

This project is built as an ES6 module, and should one day be publicly available in npm. Until then it will have to be built manually and added to your project's package.json with the path to the directory the build is in.

```
import createMupen64PlusWeb from 'mupen64plus-web';

// Inside some async function:

const emulatorControls = await createMupen64PlusWeb({

  // REQUIRED: This canvas' id has to be 'canvas' for... reasons
  canvas: document.getElementById('canvas'),

  // REQUIRED: An arraybuffer containing the rom data to play
  romData: uiState.selectedRomData,

  // OPTIONAL: These get called roughly before and after each frame
  beginStats: () => {},
  endStats: () => {},

  // OPTIONAL
  coreConfig: {
    emuMode: 0 // 0=pure-interpretter (default)(seems to be more stable), 1=cached
  },

  // OPTIONAL
  netplayConfig: {
    player: 1, // The player (1-4) that we would like to control
    reliableChannel: myChannel, // websocket-like object that can send and receive the 'tcp' messages described at https://mupen64plus.org/wiki/index.php?title=Mupen64Plus_v2.0_Core_Netplay_Protocol
    unreliableChannel: myChannel2, // websocket-like object that can send and receive the 'udp' messages described at the link above
  },

  // OPTIONAL - Can be used to point to files that the emulator needs if they are moved for whatever reason
  locateFile: (path: string, prefix: string) => {

    const publicURL = process.env.PUBLIC_URL;

    if (path.endsWith('.wasm') || path.endsWith('.data')) {
      return publicURL + "/dist/" + path;
    }

    return prefix + path;
  },

  // OPTIONAL - Can be used to get notifications for uncaught exceptions
  setErrorStatus: (errorMessage: string) => {
    console.log("errorMessage: %s", errorMessage);
  }
});

// These should be somewhat self-explanatory. Note that
// in version 1.x.x+ `start()` needs to be called
// explicitly, otherwise nothing will happen.
emulatorControls.start();

emulatorControls.pause();

emulatorControls.resume();

```

There are also some additional utility functions for interacting with the long-term idbfs storage. Check those out in scripts/main.js.


# Status
* Glide64mk2 plugin builds(?) but doesn't work correctly. Rice is the only working video plugin currently
* Some games have issues where the textures seem to draw in the wrong order

