// The correct import for createModule will be injected during the build process
import baseModule from './module';

/*
 * Saves the specified file to the IndexedDB store where 
 * the emulator can pick it up. Will overwrite any existing
 * file with the same fileName. Shouldn't be done while the 
 * emulator is running.
 *
 * - fileName should be the rom 'goodname' for the title the save is 
 * for, along with the appropriate extension for the save type. 
 * For example: `Super Smash Bros. (U) [!].sra'
 * - fileData should be an arraybuffer containing the file data.
 */
const putSaveFile = function(fileName, fileData) {

  return new Promise(function(resolve, reject) {
    
    const connection = indexedDB.open('/mupen64plus');
    
    connection.onupgradeneeded = function(e) {
      var db = e.target.result;

      if (!db.objectStoreNames.contains('FILE_DATA')) {
        const objectStore = db.createObjectStore('FILE_DATA');
        objectStore.createIndex('timestamp', 'timestamp', { unique: false, multiEntry: false });

        // Create savefile folder
        objectStore.add({
          timestamp: new Date(Date.now()),
          mode: 16832
        }, "/mupen64plus/saves");
      }
    }
    
    connection.onsuccess = (e) => {
      const db = e.target.result;
      const transaction = db.transaction('FILE_DATA', 'readwrite');
      const store = transaction.objectStore('FILE_DATA');

      const toSave = {
        contents: new Int8Array(fileData),
        timestamp: new Date(Date.now()),
        mode: 33206 // whatever this means
      };

      const savePath = '/mupen64plus/saves/' + fileName;
      const request = store.put(toSave, savePath);

      request.onerror = function(event) {
        console.error("Error while updating IDBFS store: %o", event);
        reject(event);
      }
      
      request.onsuccess = function(event) {
        resolve();
      }
    }

  });
}

const getFile = function(db, fileKey) {

  return new Promise(function(resolve, reject) {
    
    const transaction = db.transaction('FILE_DATA', 'readwrite');
    const store = transaction.objectStore('FILE_DATA');

    const request = store.get(fileKey);

    request.onerror = function(event) {
      console.error("Error while loading file %s from IDBFS: %o", fileKey, event);
      reject(event);
    }
    
    request.onsuccess = function(event) {
      console.log(event);
      resolve({ fileKey, contents: event.target.result.contents });
    }
  });
}

const getAllSaveFiles = function() {
  return new Promise(function(resolve, reject) {
    
    const connection = indexedDB.open('/mupen64plus');
    
    connection.onsuccess = (e) => {
      const db = e.target.result;

      if (!db.objectStoreNames.contains('FILE_DATA')) {
        resolve([]);
      }
      
      const transaction = db.transaction('FILE_DATA', 'readwrite');
      const store = transaction.objectStore('FILE_DATA');

      const request = store.getAllKeys();

      request.onerror = function(event) {
        console.error("Error while querying keys from IDBFS: %o", event);
        reject(event);
      }
      
      request.onsuccess = function(event) {
        console.log(event);

        const keys = event.target.result;

        const saveFileKeys = keys.filter((key) => {
          return key !== '/mupen64plus/saves' && key.includes("/mupen64plus/saves");
        });

        const getFilePromises = saveFileKeys.map((key) => {
          return getFile(db, key);
        });

        Promise.all(getFilePromises).then((results) => {
          resolve(results);
        });
      }
    }    
  });
}

const createMupen64PlusWeb = function(extraModuleArgs) {

  console.log(baseModule);
  const m = Object.assign({}, baseModule, extraModuleArgs);

  console.log(m);
  console.log("createMupen64PlusWeb main");

  if (!m.canvas) {
    throw "No canvas element provided for mupen64PlusWeb to use!";
  }

  if (!m.romData) {
    throw "No rom specified for emulation!";
  }

  if (!m.coreConfig.emuMode || m.coreConfig.emuMode < 0 || m.coreConfig.emuMode > 3) {
    m.coreConfig.emuMode = 0;
  }
  
  // As a default initial behavior, pop up an alert when webgl context is lost. To make your
  // application robust, you may want to override this behavior before shipping!
  // See http://www.khronos.org/registry/webgl/specs/latest/1.0/#5.15.2
  m.canvas.addEventListener("webglcontextlost", function(e) { alert('WebGL context lost. You will need to reload the page.'); e.preventDefault(); }, false);

  console.log("createModule: %o", createModule);
  
  return createModule(m);
}

export {
  putSaveFile,
  getAllSaveFiles
}
export default createMupen64PlusWeb;

