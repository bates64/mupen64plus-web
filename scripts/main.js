import createModule from './index';
import baseModule from './module';

const createMupen64PlusWeb = function(extraModuleArgs) {

  console.log(baseModule);
  const m = Object.assign({}, baseModule, extraModuleArgs);

  console.log(m);
  console.log("createMupen64PlusWeb main");

  if (!m.canvas) {
    throw "No canvas element provided for mupen64PlusWeb to use!";
  }

  if (!m.romPath) {
    throw "No rom specified for emulation!";
  }
  
  // As a default initial behavior, pop up an alert when webgl context is lost. To make your
  // application robust, you may want to override this behavior before shipping!
  // See http://www.khronos.org/registry/webgl/specs/latest/1.0/#5.15.2
  m.canvas.addEventListener("webglcontextlost", function(e) { alert('WebGL context lost. You will need to reload the page.'); e.preventDefault(); }, false);

  console.log("createModule: %o", createModule);
  
  return createModule(m);
}

export default createMupen64PlusWeb;
