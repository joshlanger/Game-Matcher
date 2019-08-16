function callZipCodeAPI(zip1, zip2) {
    //let url = `https://www.zipcodeapi.com/rest/8U535hnNOsKGQMczw9Ii6Em8khinbAWwJgCcHENrckuTCfbUGiUOhldBRa7L57in/distance.json/${zip1}/${zip2}/mile`;
    //let url = `https://www.zipcodeapi.com/rest/js-e6a7SjtLkiBAaTVviTNSRYqbsxAx5VG9szwRzCmM1pmAi3KZylJ0pdHLyaw0kHVw/distance.json/${zip1}/${zip2}/mile`;
    let url = `https://localhost:44392/api/zip/zipdistance?zip1=${zip1}&zip2=${zip2}`;
    fetch(url, {
        method: 'GET', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, cors, *same-origin
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    })
        .then((response) => {
            console.log(response);
            return response.json();
        })
        .then((data) => {
            console.log("Yello");
            console.log(data);
            console.log("Distance: " + data);
        })
        .catch((error) => {
            console.log(error);
        });
}

document.addEventListener("DOMContentLoaded", () => {
    callZipCodeAPI(15222, 15201);

});