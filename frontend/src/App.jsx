import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import Login from "./features/auth/Login";
import ProtectedRoute from "./components/common/ProtectedRoute";
import LogoutButton from "./components/common/LogoutButton";
import AdminDashboard from "./features/admin/AdminDashboard"

function App() {
  return (
    <>
      <ToastContainer position="top-right" />

      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/login" element={<Login />} />

          <Route
            path="/admin"
            element={
              <ProtectedRoute role="ADMIN">
                <AdminDashboard />
              </ProtectedRoute>
            }
          />

          <Route
            path="/dashboard"
            element={
              <ProtectedRoute role="USER">
                <div>
                  <h1>User Dashboard</h1>
                  <LogoutButton />
                </div>
              </ProtectedRoute>
            }
          />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;