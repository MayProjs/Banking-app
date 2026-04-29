import { useEffect, useState } from "react";
import axios from "axios";
import API_BASE from "../../api/api";
import LogoutButton from "../../components/common/LogoutButton";

export default function AdminDashboard() {
  const [transactions, setTransactions] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchTransactions = async () => {
    try {
      const res = await axios.get(
        `${API_BASE}/api/admin/transactions`
      );
      setTransactions(res.data);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchTransactions();
  }, []);

  return (
    <div style={{ padding: "20px" }}>
      <h2>Admin Dashboard</h2>
      <LogoutButton />

      {loading ? (
        <p>Loading transactions...</p>
      ) : (
        <table border="1" cellPadding="10">
          <thead>
            <tr>
              <th>ID</th>
              <th>From</th>
              <th>To</th>
              <th>Amount</th>
              <th>Type</th>
              <th>Channel</th>
              <th>Status</th>
              <th>Date</th>
            </tr>
          </thead>

         <tbody>
            {transactions.map((txn) => (
              <tr key={txn.transactionId}>
                <td>{txn.transactionId}</td>
                <td>{txn.fromAccount || "-"}</td>
                <td>{txn.toAccount || "-"}</td>
                <td>{txn.amount}</td>
                <td>{txn.transactionType}</td>
                <td>{txn.transactionChannel}</td>
                <td>{txn.status}</td>
                <td>{txn.transactionDate}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}