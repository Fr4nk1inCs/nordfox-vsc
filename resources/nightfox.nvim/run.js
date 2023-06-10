const fs = require("fs");
const {
  palette: { ansi, ...baseColors },
  specs,
} = require("./dayfox.json");

function drawColor(name, color) {
  return /* HTML */ `<article class="color" style="background-color: ${color}">
    <span>${name}</span><br /><span class="color-hex">${color}</span>
  </article> `;
}

function drawColorRow(colors) {
  return /* HTML */ `<section class="color-row">
    ${Object.entries(colors)
      .map(([name, color]) => drawColor(name, color))
      .join("")}
  </section>`;
}

let content = "";
content += `<h2>Palette</h2>\n`;

content += `<h3>Base colors</h3>\n`;
content += drawColorRow(baseColors);
content += `<hr>\n`;

content += `<h3>Ansi colors</h3>\n`;
for (const [ansiColorName, ansiColorVariants] of Object.entries(ansi)) {
  content += `<h4>${ansiColorName}</h4>\n`;
  content += `<div class="color-row">\n`;
  for (const variant of ["base", "bright", "dim"]) {
    content += drawColor(variant, ansiColorVariants[variant]);
  }
  content += `</div>\n`;
}
content += `<hr>\n`;

content += `<h2>Specs</h2>\n`;

content += `<h3>Syntax</h3>\n`;
content += drawColorRow(specs.syntax);
content += `<hr>\n`;

content += `<h3>Git</h3>\n`;
content += drawColorRow(specs.git);
content += `<hr>\n`;

content += `<h3>Diff</h3>\n`;
content += drawColorRow(specs.diff);
content += `<hr>\n`;

content += `<h3>Diagnostics</h3>\n`;
content += drawColorRow(specs.diag);
content += `<hr>\n`;

content += `<h3>Diagnostics background</h3>\n`;
content += drawColorRow(specs.diag_bg);

const file = /* HTML */ `
  <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <title>Dayfox</title>
      <style>
        body {
          font-family: monospace;
        }
        h1 {
          text-align: center;
        }
        main {
          max-width: 400px;
          margin: 0 auto;
        }
        .color-row {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 12px;
          margin-bottom: 24px;
        }
        .color {
          color: white;
          text-align: center;
          text-shadow: 1px 1px 2px #000;
          aspect-ratio: 1;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
        }
        .color-hex {
          user-select: all;
        }
      </style>
    </head>
    <main>
      <h1>Dayfox</h1>
      ${content}
    </main>
  </html>
`;

fs.writeFileSync("./dayfox.html", file);
