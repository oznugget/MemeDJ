import { Elm } from './Main.elm';

let currentAudio = null; // Keep track of the currently playing sound

const app = Elm.Main.init({
  node: document.getElementById('app')
});

app.ports.playSound.subscribe((filename) => {
  const soundPath = `sounds/${filename}`;

  // Stop any currently playing audio
  if (currentAudio) {
    currentAudio.pause();
    currentAudio.currentTime = 0; // Rewind for next play
    currentAudio = null;
  }

  try {
    const audio = new Audio(soundPath);
    currentAudio = audio;
    audio.play().catch((err) => {
      console.warn('Audio play failed (placeholder or missing file):', err);
    });
  } catch (e) {
    console.error('Error creating Audio object:', e);
  }
});