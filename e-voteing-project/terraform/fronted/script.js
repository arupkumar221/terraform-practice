function vote() {

const data = {
  name:
  document.getElementById("name").value,

  candidate:
  document.getElementById("candidate").value
};

fetch("http://BACKEND_PRIVATE_IP:5000/vote", {
  method: "POST",
  headers: {
    "Content-Type":
    "application/json"
  },
  body: JSON.stringify(data)
})
.then(r => r.json())
.then(d => {
  document.getElementById("msg").innerHTML =
  d.message;
});
}
