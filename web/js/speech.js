let recognition;
let finalCallback;
let stopCallback;
let startCallback;
let levelCallback;
let startedFired = false;

let meterStream;
let meterContext;
let meterSource;
let meterAnalyser;
let meterData;
let meterFrameId;
let smoothedLevel = 0;
let meterRequestId = 0;

function emitLevel(level) {
  if (levelCallback) {
    levelCallback(level);
  }
}

function stopLevelMeter() {
  meterRequestId += 1;

  if (meterFrameId) {
    cancelAnimationFrame(meterFrameId);
    meterFrameId = null;
  }

  if (meterSource) {
    try {
      meterSource.disconnect();
    } catch (_) {}
    meterSource = null;
  }

  if (meterAnalyser) {
    try {
      meterAnalyser.disconnect();
    } catch (_) {}
    meterAnalyser = null;
  }

  if (meterStream) {
    try {
      meterStream.getTracks().forEach((track) => track.stop());
    } catch (_) {}
    meterStream = null;
  }

  if (meterContext) {
    try {
      meterContext.close();
    } catch (_) {}
    meterContext = null;
  }

  meterData = null;
  smoothedLevel = 0;
  emitLevel(0);
}

function pumpLevel(requestId) {
  if (requestId !== meterRequestId || !meterAnalyser || !meterData) {
    emitLevel(0);
    return;
  }

  meterAnalyser.getByteTimeDomainData(meterData);

  let sumSquares = 0;
  for (let i = 0; i < meterData.length; i += 1) {
    const centeredSample = (meterData[i] - 128) / 128;
    sumSquares += centeredSample * centeredSample;
  }

  const rms = Math.sqrt(sumSquares / meterData.length);
  const normalized = Math.min(1, rms * 5.5);
  smoothedLevel = Math.max(normalized, smoothedLevel * 0.82);
  emitLevel(smoothedLevel);

  meterFrameId = requestAnimationFrame(() => pumpLevel(requestId));
}

function startLevelMeter() {
  stopLevelMeter();
  const requestId = meterRequestId;

  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    console.log("[speech.js] getUserMedia not available for level meter");
    emitLevel(0);
    return;
  }

  const AudioContextCtor = window.AudioContext || window.webkitAudioContext;
  if (!AudioContextCtor) {
    console.log("[speech.js] AudioContext not available for level meter");
    emitLevel(0);
    return;
  }

  navigator.mediaDevices
    .getUserMedia({
      audio: {
        echoCancellation: true,
        noiseSuppression: true,
        autoGainControl: true,
      },
    })
    .then((stream) => {
      if (requestId !== meterRequestId) {
        stream.getTracks().forEach((track) => track.stop());
        return;
      }

      meterStream = stream;
      meterContext = new AudioContextCtor();
      meterSource = meterContext.createMediaStreamSource(stream);
      meterAnalyser = meterContext.createAnalyser();
      meterAnalyser.fftSize = 256;
      meterAnalyser.smoothingTimeConstant = 0.65;
      meterData = new Uint8Array(meterAnalyser.fftSize);
      meterSource.connect(meterAnalyser);
      smoothedLevel = 0;

      if (meterContext.state === "suspended") {
        meterContext.resume().catch((err) => {
          console.warn("[speech.js] meterContext resume failed:", err);
        });
      }

      pumpLevel(requestId);
    })
    .catch((err) => {
      console.warn("[speech.js] level meter unavailable:", err);
      stopLevelMeter();
    });
}

function initSpeechRecognition() {
  const SpeechRecognition =
    window.SpeechRecognition || window.webkitSpeechRecognition;

  if (!SpeechRecognition) {
    console.log("[speech.js] Speech API not supported");
    return false;
  }

  recognition = new SpeechRecognition();
  recognition.lang = "en-US";
  recognition.continuous = false;
  recognition.interimResults = false;

  recognition.onstart = () => {
    console.log("[speech.js] recognition.onstart");
    startedFired = true;
    if (startCallback) startCallback("started");
  };

  recognition.onresult = (event) => {
    try {
      if (!startedFired) {
        startedFired = true;
        if (startCallback) startCallback("started");
      }

      const text = event.results[0][0].transcript;
      console.log("[speech.js] onresult:", text);
      if (finalCallback) finalCallback(text);
    } catch (e) {
      console.error("[speech.js] onresult parse error:", e);
    }
  };

  recognition.onend = () => {
    console.log("[speech.js] recognition.onend");
    startedFired = false;
    stopLevelMeter();
    if (stopCallback) stopCallback("ended");
  };

  recognition.onerror = (e) => {
    console.error("[speech.js] recognition.onerror:", e);
    startedFired = false;
    stopLevelMeter();
    if (stopCallback) stopCallback("error");
  };

  return true;
}

function startSpeechRecognition(onResult, onStopped, onStarted, onLevel) {
  finalCallback = onResult;
  stopCallback = onStopped;
  startCallback = onStarted;
  levelCallback = onLevel;
  startedFired = false;

  if (!recognition) {
    console.error("[speech.js] Speech recognition not initialized");
    if (stopCallback) stopCallback("error");
    return;
  }

  try {
    console.log("[speech.js] starting recognition (synchronous)");
    recognition.start();
    startLevelMeter();

    if (navigator.permissions && navigator.permissions.query) {
      try {
        navigator.permissions
          .query({ name: "microphone" })
          .then((permStatus) => {
            try {
              console.log("[speech.js] permission state:", permStatus.state);
              if (permStatus.state === "granted" && !startedFired) {
                startedFired = true;
                if (startCallback) startCallback("started");
              }

              permStatus.onchange = function () {
                console.log(
                  "[speech.js] permission changed to:",
                  permStatus.state,
                );
                if (permStatus.state === "granted" && !startedFired) {
                  startedFired = true;
                  if (startCallback) startCallback("started");
                }
              };
            } catch (e) {
              console.warn("[speech.js] permission API inner error:", e);
            }
          })
          .catch((err) => {
            console.warn("[speech.js] permissions.query failed:", err);
          });
      } catch (e) {
        console.warn("[speech.js] permissions API usage error:", e);
      }
    } else {
      console.log(
        "[speech.js] Permissions API not available, relying on onstart/onresult",
      );
    }
  } catch (e) {
    console.error("[speech.js] recognition.start() failed:", e);
    stopLevelMeter();
    if (stopCallback) stopCallback("error");
  }
}

function stopSpeechRecognition() {
  try {
    console.log("[speech.js] stopSpeechRecognition()");
    stopLevelMeter();
    if (recognition) recognition.stop();
  } catch (e) {
    console.error("[speech.js] stopSpeechRecognition error:", e);
  }
}
