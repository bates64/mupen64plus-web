const fs = require('fs');
const yargs = require('yargs');

const argv = yargs
  .command('iniToJson', 'Converts an m64p ini file to json', {
    input: {
      description: 'Input ini file',
      alias: 'i',
      type: 'string'
    }
  })
  .option('output', {
    alias: 'o',
    description: 'Where to output the produced json file',
    type: 'string'
  })
  .help()
  .argv;

fs.readFile(argv.i, 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  //console.log(data);

  const lines = data.split("\n");
  const configEntries = {};
  
  for (const key in lines) {
    const lineNumber = parseInt(key);
    const line = lines[lineNumber];

    if (line[0] === '[') {
      const md5 = line.replace('[', '').replace(']', '').trim();

      const configLength = lines.slice(lineNumber, lines.length)
                                       .findIndex((l) => {
                                         return l.trim() === '';
                                       });

      const config = {};
      
      for (const configLine of lines.slice(lineNumber + 1, lineNumber + configLength)) {
        const entry = configLine.trim().split('=');
        const key = entry[0];
        const value = entry[1];

        config[key] = value;
      }

      configEntries[md5] = config;
    }
  }

  fs.writeFile(argv.o, JSON.stringify(configEntries, null, 2), err => {
    if (err) {
      console.error(err);
      return;
    }

    console.log("mupen64plus.ini successfully converted to mupen64plus.json!");
  });
});
