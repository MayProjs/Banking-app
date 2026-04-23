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


    if (isNaN(form.amount) || Number(form.amount) <= 0) {
      toast.error("Enter a valid amount");
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
        `${API_BASE}/api/transactions/withdraw`,
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

        <button onClick={handleSubmit} disabled={loading}>
            {loading ? "Processing..." : "Deposit"}
        </button>
        
      </div>
    </div>
  );
}