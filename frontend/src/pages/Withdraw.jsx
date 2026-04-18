import { useState } from "react";
import API_BASE from "./api";
import { toast } from "react-toastify";
import axios from "axios";
import Sidebar from "../components/Sidebar"; 

export default function WithdrawForm() {
  const [form, setForm] = useState({
    accountId: "",
    amount: "",
    channel: "NET_BANKING", // default channel
  });

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async () => {
    if (!form.accountId || !form.amount) {
      toast.error("Please fill all fields");
      return;
    }

    if (isNaN(form.amount) || Number(form.amount) <= 0) {
      toast.error("Enter a valid amount");
      return;
    }

    try {
      const res = await axios.post(
        `${API_BASE}/api/transactions/withdraw`,
        form
      );

      toast.success(res.data);
    } catch (err) {
       toast.error(
            err.response?.data?.message || 
            err.response?.data || 
            "Something went wrong"
      );
    }
  };

  return (
    <div style={{ display: "flex",  minHeight: "100vh", width: "100%"  }}>
          <Sidebar />
    
        
        <div style={{ flex:1, padding: "20px" }}>
        <h2>Withdraw</h2>

        <input
          name="accountId"
          placeholder="Account ID"
          onChange={handleChange}
        />

        <input
          name="amount"
          placeholder="Amount"
          onChange={handleChange}
        />

        <button onClick={handleSubmit}>Withdraw</button>
      </div>
    </div>
  );
}