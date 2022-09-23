
declare module 'mupen64plus-web' {

  export interface FileEntry {
    fileKey: string,
    contents: Int8Array
  }

  export interface EmulatorControls {
    start: () => Promise<void>,
    stop: () => void,
    pause: (netplayPauseTargetCounts?: number[]) => Promise<(number[]) | null>,
    resume: () => Promise<void>,
    forceDumpSaveFiles: () => Promise<void>
    softReset(): void
    hardReset(): void
    advanceFrame(): void
    reloadRom(romData: ArrayBuffer): Promise<void>
    getDram(): Uint32Array
  }

  export interface CoreConfig {
    canvas: HTMLCanvasElement,
    romData: ArrayBuffer,
    beginStats?: () => void,
    endStats?: () => void,
    coreConfig?: {
      emuMode?: number
    },
    netplayConfig?: {
      player: number,
      reliableChannel: any,
      unreliableChannel: any
    },
    locateFile?: (path: string, prefix: string) => string,
    setErrorStatus?: (errorMessage: string) => void
  }

  export default function createMupen64PlusWeb(config: CoreConfig): Promise<EmulatorControls>;
  export function putSaveFile(fileName: string, fileData: ArrayBuffer): Promise<void>;
  export function getAllSaveFiles(): Promise<FileEntry[]>;
  export function findAutoInputConfig(gamepadName: string): Promise<any>;
  export function writeAutoInputConfig(gamepadName: string, config: any): Promise<void>;

}


