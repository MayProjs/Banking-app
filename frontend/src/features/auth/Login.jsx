import { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import API_BASE from "../../api/api";
import { toast } from "react-toastify";

export default function Login() {
  const navigate = useNavigate();

  const [form, setForm] = useState({
    email: "",
    password: ""
  });

  const [loading, setLoading] = useState(false);

  // auto redirect if already logged in
  useEffect(() => {
    const user = JSON.parse(localStorage.getItem("user"));

    if (user) {
      if (user.role === "ADMIN") navigate("/admin");
      else navigate("/dashboard");
    }
  }, []);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleLogin = async () => {
    setLoading(true);

    if (!form.email || !form.password) {
      toast.error("Please fill all fields");
      setLoading(false);
      return;
    }

    try {
      const res = await axios.post(
        `${API_BASE}/api/auth/login`,
        form
      );

      localStorage.setItem("user", JSON.stringify(res.data));

      toast.success("Login successful");

      if (res.data.role === "ADMIN") {
        navigate("/admin");
      } else {
        navigate("/dashboard");
      }

    } catch (err) {
      toast.error(
        err.response?.data?.message || "Login failed"
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: "40px" }}>
      <h2>Login</h2>

      <input
        name="email"
        placeholder="Email"
        onChange={handleChange}
      />

      <br /><br />

      <input
        type="password"
        name="password"
        placeholder="Password"
        onChange={handleChange}
      />

      <br /><br />

      <button onClick={handleLogin} disabled={loading}>
        {loading ? "Logging in..." : "Login"}
      </button>
    </div>
  );
}