# Sound-To-Vision 🎵👀

Transforming Sound into Sight for the Hearing Impaired

---

## 🌍 Inspiration

According to the World Health Organization (WHO), over 430 million people worldwide have disabling hearing loss. Many essential environmental sounds, such as sirens, vehicle horns, or doorbells, are crucial for safety and daily life. Sound-To-Vision is designed to empower individuals with hearing impairments by converting real-world sounds into visual and sensory cues.

---

## 🌐 Problem Statement
People with hearing disabilities often miss critical auditory cues. Our app solves this by **detecting specific sounds in real-time** and **displaying visual alerts**, ensuring they stay aware of their surroundings.

---
## 🔧 How It Works

1.  **Real-Time Audio Capture**
   The app continuously listens to environmental sounds.
2. **Sound Classification via TFLite Model**  A lightweight **CNN model (converted to TFLite)** detects one of the predefined sound categories.
3. **Visual Notification**
   Based on the recognized sound category, the app triggers specific visual, vibration, and notification alerts.
4. For ex: if an animal sound is detected then the phone vibrates and displays animal image .
---

## 🎉 Features
- 📻 **Detects 6 Key Sound Categories:**
  - Animal Sound
  - Doorbell
  - Nature (Rain, Thunder)
  - Siren
  - Speech
  - Vehicle Horn

- 💡 **Real-time Detection**
- 🔄 **Low Power Consumption** (Efficient on-device processing)
- 🎨 **User-friendly Interface** with intuitive visual cues

---

## 🚀 Tech Stack
- **Flutter** (Front-end UI/UX)
- **Python** (Model training + audio preprocessing)
- **TensorFlow + Keras** (Model building)
- **TFLite** (Optimized deployment on mobile)
- **MFCC** (Used for audio feature extraction)
- **Google Firebase:** 
  - **Firebase authentication** (for user login) 
  - **Firebase cloud functions** (for backend processing) 
  - **Firestore** (for storing user preferences & app data)
- **Flask API** (For cloud-based sound classification and future scalability)

---
## 🚀 Future Improvements
- 🔹 Detect more diverse sound categories (alarms, claps, shouts)
- 🔹 Offline processing with background service
- 🔹 Deploying the app on the Google Play Store for public use.
- 🔹 Integrating with wearable devices for real-time alerts.
- 🔹Integrate ML model using Flask API in future for more flexibility & easy.
- 🔹Optimize it using Gunicorn and Docker to improve performance and make deployment scalable.

---

## 🙏 Acknowledgements
- **Mixkit** for free sound effects dataset
- **TensorFlow** for model training tools
- **Flutter** community for UI inspirations
- **firebase** for authentication
- **flask api** for future scalability
- **librosa** for audio processing

---


