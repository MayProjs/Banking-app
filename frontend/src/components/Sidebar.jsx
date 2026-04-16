import { Link } from "react-router-dom";

export default function Sidebar() {
  return (
    <div
      style={{
        width: "220px",              // ✅ fixed width
        background: "#f8f9fb",
        padding: "20px",
        borderRight: "1px solid #e5e7eb", // ✅ separator line
        minHeight: "100vh",          // ✅ full height
      }}
    >
      <h3>May's Bank</h3>

      <p><Link to="/">Dashboard</Link></p>
      <p><Link to="/transfer">Transfers</Link></p>
      <p><Link to="/withdraw">Withdrawals</Link></p>
      <p><Link to="/deposit">Deposits</Link></p>
    </div>
  );
}