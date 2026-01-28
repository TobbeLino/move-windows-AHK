const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

function fail(message) {
  console.error(message);
  process.exit(1);
}

const repoRoot = path.resolve(__dirname, '.');
const pkgPath = path.join(repoRoot, 'package.json');
const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));

const versionGeneratedPath = path.join(repoRoot, 'src', 'version.generated.ahk');
const versionGenerated = `; GENERATED FILE. Do not edit by hand.\r\nglobal SCRIPT_VERSION := "${pkg.version}"\r\n`;
fs.writeFileSync(versionGeneratedPath, versionGenerated, 'utf8');

const distDir = path.join(repoRoot, 'dist');
fs.mkdirSync(distDir, { recursive: true });

const ahk2exe =
  process.env.AHK2EXE ||
  'C:\\Program Files\\AutoHotkey\\Compiler\\Ahk2Exe.exe';

const inFile = path.join(repoRoot, 'src', 'move-windows.ahk');
const outFile = path.join(distDir, 'move-windows.exe');
const iconFile = path.join(repoRoot, 'assets', 'move-windows.ico');

const args = ['/in', inFile, '/out', outFile, '/icon', iconFile];

const res = spawnSync(ahk2exe, args, {
  stdio: 'inherit',
  windowsHide: true,
});

if (res.error) {
  fail(`Failed to run Ahk2Exe: ${res.error.message}`);
}
process.exit(res.status ?? 1);

