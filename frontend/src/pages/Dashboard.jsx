import Sidebar from "../components/Sidebar";

export default function Dashboard() {
  return (
    <div style={{ display: "flex" }}>
      <Sidebar />

      <div style={{ padding: "20px", flex: 1 }}>
        <h1>Welcome back, Mayuresh 👋</h1>

        <div style={{ display: "flex", gap: "20px" }}>
          <div style={{ padding: "20px", background: "#fff", borderRadius: "10px" }}>
            <h3>Balance</h3>
            <p>₹1,28,104</p>
          </div>

          <div style={{ padding: "20px", background: "#fff", borderRadius: "10px" }}>
            <h3>Recent Activity</h3>
            <p>Coming soon...</p>
          </div>
        </div>
      </div>
    </div>
  );
}