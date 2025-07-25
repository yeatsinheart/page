document.getElementById('file-input').addEventListener('change', async (event) => {
  const file = event.target.files[0];
  if (!file) return;

  const reader = new FileReader();
  reader.onload = () => {
    const content = reader.result;
    parent.postMessage({ pluginMessage: { type: 'import-json', content } }, '*');
  };
  reader.readAsText(file);
});


document.getElementById('file').addEventListener('change', (event) => {
  const file = event.target.files[0];
  const reader = new FileReader();
  reader.onload = () => {
    const json = reader.result;
    parent.postMessage({ pluginMessage: { type: 'import-styles', data: json } }, '*');
  };
  reader.readAsText(file);
});
