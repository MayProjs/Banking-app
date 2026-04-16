import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import Dashboard from "./pages/Dashboard";
import Transfer from "./pages/Transfer";
import Deposit from "./pages/Deposit";
import Withdraw from "./pages/Withdraw";

function App() {
  return (
     <>
      <ToastContainer />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/transfer" element={<Transfer />} />
            <Route path="/deposit" element={<Deposit />} />
            <Route path="/withdraw" element={<Withdraw />} />
          </Routes>
        </BrowserRouter>
    </>
  );
}

export default App;