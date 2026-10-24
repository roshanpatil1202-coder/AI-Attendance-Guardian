# CampusVision AI — College Face Attendance Management System

A production-ready, full-stack **AI Face Attendance Management System** tailored for collegiate institutions. Built with **React 18 + Vite** on the frontend, **Node.js + Express + SQLite** on the backend, and powered by client-side **TensorFlow/Face-API** neural networks for real-time face detection, 128-dimensional biometric embeddings, and interactive 4-stage liveness verification.

---

## Features & Highlights

- **3 Dedicated User Roles**:
  - **Admin**: Full college oversight — manage faculty, students, academic classes, subjects, attendance audit logs, and college-wide aggregated reports.
  - **Teacher**: Strictly scoped to assigned classes and courses — schedule lectures with conflict detection, take attendance via AI camera, register student face descriptors, perform manual overrides, and export CSV/print reports.
  - **Student**: View personal attendance percentage, subject-by-subject attendance breakdown, date-wise logs, upcoming lecture timetable, and self-service biometric face enrollment.
- **AI Vision & Biometrics**:
  - Offline-bundled Face-API weights (SSD MobileNet / TinyFace, 68-point facial landmarks, and 128-d face recognition net) stored directly in `frontend/public/models/`.
  - **Interactive 4-Step Liveness Verification**:
    1. **Look at camera**: Confirms single face centered in frame with high confidence.
    2. **Blink detection**: Monitors Eye Aspect Ratio (EAR) dip and recovery.
    3. **Head turn**: Measures horizontal landmark displacement (yaw angle) confirming 3D head movement.
    4. **Liveness verified**: Captures high-quality face descriptor.
- **Enterprise Safeguards**:
  - **Wrong Student Protection**: Face descriptors are compared **only** against enrolled students in the selected class cohort.
  - **Duplicate Prevention**: A student cannot be marked twice for the same lecture session.
  - **Unknown Face Protection**: Unrecognized faces are never marked present automatically.
  - **Multiple Faces Alert**: Immediate warning if more than one individual appears in the camera frame.
  - **Lecture Conflict Prevention**: Blocks double-booking of faculty members or classrooms during overlapping time slots.

---

## Tech Stack

- **Frontend**: React 18, Vite 5, React Router v6, Axios, Lucide React Icons
- **AI Engine**: Face-API.js (`@vladmandic/face-api`), Canvas API, WebRTC MediaStream
- **Backend**: Node.js, Express.js, JWT Authentication, bcryptjs
- **Database**: SQLite3 with WAL mode and foreign key integrity (Prisma schema compliant)

---

## Project Structure

```text
ai-attendance/
├── frontend/
│   ├── public/
│   │   └── models/               # Offline Face-API neural network model weights
│   ├── src/
│   │   ├── components/
│   │   │   ├── ai/               # FaceRecognitionCamera.jsx (liveness & vision)
│   │   │   └── common/           # Navbar, Sidebar, ProtectedRoute, Modal
│   │   ├── context/              # AuthContext.jsx
│   │   ├── pages/
│   │   │   ├── admin/            # Dashboard, Teachers, Students, Classes, Subjects, Reports
│   │   │   ├── teacher/          # Dashboard, TakeAttendance, Students, Schedule, Reports, Profile
│   │   │   ├── student/          # Dashboard, Attendance, DateLog, Schedule, FaceRegistration, Profile
│   │   │   └── public/           # LoginPage, RegisterStudentPage
│   │   ├── services/             # Axios API service with JWT injection
│   │   ├── App.jsx               # Router configuration & protected route trees
│   │   └── index.css             # Unified modern theme & print stylesheet
│   ├── package.json
│   └── vite.config.js
│
├── backend/
│   ├── prisma/
│   │   └── schema.prisma         # Formal Prisma database schema
│   ├── src/
│   │   ├── controllers/          # auth, admin, teacher, student, attendance controllers
│   │   ├── database/             # SQLite connection (db.js) and seeder (seed.js)
│   │   ├── middleware/           # auth.js (JWT verify & role authorization)
│   │   ├── routes/               # Express route definitions
│   │   └── server.js             # Server bootstrap on port 5000
│   ├── data/                     # SQLite database file (attendance.db)
│   ├── package.json
│   └── .env.example
│
└── README.md
```

---

## Getting Started

### Prerequisites

- **Node.js** (v18.x or higher)
- **npm** (v9.x or higher)

### 1. Installation

Clone or open the project folder in VS Code (`C:\Users\91902\.gemini\antigravity\scratch\ai-attendance`):

```bash
# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

### 2. Database Initialization & Seeding

Run the automated seeder to initialize the SQLite database schema and load realistic demo records:

```bash
cd backend
npm run seed
```

This populates classes, subjects, professors, students, historical lectures, and attendance records.

### 3. Run Backend

In your backend terminal:

```bash
cd backend
npm run dev
# or: npm start
```

Backend will start at: **`http://localhost:5000`**
Health check endpoint: `http://localhost:5000/api/health`

### 4. Run Frontend

In a separate terminal window:

```bash
cd frontend
npm run dev
```

Frontend will start at: **`http://localhost:5173`**

Open your browser and navigate to **`http://localhost:5173`**.

---

## Demo Accounts

The login interface includes 1-click **Quick Fill Demo** buttons for instant testing:

| Role | Email Address | Password | Details |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin@college.edu` | `Admin@123` | Full system administrator |
| **Teacher** | `teacher@college.edu` | `Teacher@123` | Prof. Vikram Sharma (Computer Applications) |
| **Teacher** | `anita@college.edu` | `Teacher@123` | Dr. Anita Desai (Computer Science) |
| **Student** | `student@college.edu` | `Student@123` | Rahul Patil (BCA 2nd Year, Roll No: 23) |

---

## Step-by-Step AI Attendance Workflow

1. **Sign in as Teacher**: Use `teacher@college.edu` / `Teacher@123`.
2. **Register a Student Face** (if not yet registered):
   - Navigate to **Class Students** in the sidebar.
   - Click **Register Face** next to any student (e.g. Rahul Patil).
   - Position face in camera -> follow interactive steps (Look -> Blink -> Turn head) -> Face registered!
3. **Take Live Attendance**:
   - Navigate to **Take Attendance** in the sidebar.
   - Select: Class (`BCA 2nd Year`) → Subject (`Data Analytics`) → Scheduled Lecture → Click **Start Attendance Session**.
   - Camera opens with face tracking box.
   - Look at camera → Blink eyes → Turn head → Status indicates **Liveness Verified ✓**.
   - Student is identified with confidence score (e.g., `Rahul Patil | Roll: 23 | 96% | PRESENT`).
   - The attendance roster below updates in real-time.
   - Any manual adjustments can be toggled using the **Present / Late / Absent** buttons.
4. **View Student Perspective**:
   - Sign in as `student@college.edu` / `Student@123`.
   - Inspect the overall attendance card, subject-wise percentage table, and chronological date log.

---

## License & Notes

Developed for academic college attendance automation. Basic liveness detection verifies active interaction (blinking and head rotation) without claiming complete protection against sophisticated physical spoofing.
