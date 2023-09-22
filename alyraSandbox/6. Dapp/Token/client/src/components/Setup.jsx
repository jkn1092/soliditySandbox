import {useState} from "react";
import {useEth} from "../contexts/EthContext";

function Setup() {
    const { state } = useEth();
    const [value, setValue] = useState("");

    const onClick = async () => {
        try {

        } catch (err) {
        }
    }

    return (
    <>
      <h2>Preparation</h2>
        <input type="text"
               onChange={(e) => setValue(e.target.value)}
               autoFocus
        />
        <button onClick= { () => onClick() }>
            transfert
        </button>
    </>
  );
}

export default Setup;
