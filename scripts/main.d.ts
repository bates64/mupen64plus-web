
declare module 'mupen64plus-web' {

  export default function createMupen64PlusWeb({ }: any);
  export function putSaveFile(fileName: string, fileData: ArrayBuffer): Promise<void>;
}


