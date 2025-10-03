async function callApi() {
  const res = await fetch('http://localhost:5000/api/hello');
  const data = await res.json();
  alert('Backend says: ' + data.message + ' (DB: ' + data.dbHost + ')');
}