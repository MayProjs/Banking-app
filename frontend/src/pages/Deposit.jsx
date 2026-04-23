import { useState } from "react";
import API_BASE from "./api";
import axios from "axios";
import { toast } from "react-toastify";
import Sidebar from "../components/Sidebar";

export default function DepositForm() {
  const [form, setForm] = useState({
    accountId: "",
    amount: "",
    channel: "WEB", // default channel
  });

  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async () => {
  setLoading(true);

  if (!form.accountId || !form.amount) {
    toast.error("Please fill all fields");
    setLoading(false);
    return;
  }

  const payload = {
    accountId: Number(form.accountId),
    amount: Number(form.amount),
    channel: form.channel
  };

  try {
    const res = await axios.post(
      `${API_BASE}/api/transactions/deposit`,
      payload
    );

    toast.success(res.data);

  } catch (err) {
    toast.error(
      err.response?.data?.message ||
      err.response?.data ||
      "Something went wrong"
    );
  } finally {
    setLoading(false);
  }
};

  return (
    <div style={{ display: "flex", minHeight: "100vh", width: "100%" }}>
      <Sidebar />

      <div style={{ flex: 1, padding: "20px" }}>
        <h2>Deposit</h2>

        <input
          name="accountId"
          placeholder="Account ID"
          onChange={handleChange}
        />

        <input name="amount" placeholder="Amount" onChange={handleChange} />

        <button onClick={handleSubmit} disabled={loading}>
            {loading ? "Processing..." : "Deposit"}
        </button>
      </div>
    </div>
  );
}
